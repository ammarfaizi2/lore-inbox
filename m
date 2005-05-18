Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVERO1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVERO1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVEROKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:10:32 -0400
Received: from alog0288.analogic.com ([208.224.222.64]:64898 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262207AbVERN6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:58:22 -0400
Date: Wed, 18 May 2005 09:57:33 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Vaibhav Nivargi <vnivargi@gmail.com>
cc: Martin Zwickel <martin.zwickel@technotrend.de>,
       Filipe Abrantes <fla@inescporto.pt>, linux-kernel@vger.kernel.org
Subject: Re: Detecting link up
In-Reply-To: <e3126c290505180611620380cc@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505180949550.16627@chaos.analogic.com>
References: <428B1A60.6030505@inescporto.pt> <20050518134031.53a3243a@phoebee>
 <e3126c290505180611620380cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Vaibhav Nivargi wrote:

> try looking at the ioctls which mii-tool / ethtool make
>
> regards,
> Vaibhav
>
> On 5/18/05, Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>> On Wed, 18 May 2005 11:35:12 +0100
>> Filipe Abrantes <fla@inescporto.pt> bubbled:
>>
>>> Hi all,
>>>
>>> I need to detect when an interface (wired ethernet) has link up/down.
>>> Is  there a system signal which is sent when this happens? What is the
>>> best  way to this programatically?
>>
>> mii-tool?
>>
>> --
>> MyExcuse:
>> Not enough interrupts

>>
>> Martin Zwickel <martin.zwickel@technotrend.de>
>> Research & Development
>>
>> TechnoTrend AG <http://www.technotrend.de>



Cut from some working project........


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include <net/if.h>
#include <netinet/in.h>

typedef uint32_t u32;
typedef uint16_t u16;
typedef uint8_t  u8;

#include <linux/sockios.h>
#include <linux/ethtool.h>

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= 
//
//  Get the link status. This returns TRUE if the link is up and FALSE
//  otherwise.
//
int32_t link_stat()
{
     int s;
     struct ifreq ifr;
     struct ethtool_value eth;
     if((s = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP)) == FAIL)
         ERRORS(Socket);
     bzero(&ifr, sizeof(ifr));
     strcpy(ifr.ifr_name, Eth0);
     ifr.ifr_data = (caddr_t) &eth;
     eth.cmd      = ETHTOOL_GLINK;
     if(ioctl(s, SIOCETHTOOL, &ifr) == FAIL)
         ERRORS(Ioctl);
     (void)close(s);
     return (eth.data) ? TRUE:FALSE;
}


ERRORS, TRUE, FALSE, Eth0, FAIL are macros that you should be able
to figure out for yourself. Maybe you don't have bzero() you
can use memset(x, 0x00, n).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

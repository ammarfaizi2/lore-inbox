Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVDNSLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVDNSLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDNSLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:11:45 -0400
Received: from alog0122.analogic.com ([208.224.220.137]:17332 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261581AbVDNSLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:11:32 -0400
Date: Thu, 14 Apr 2005 14:11:26 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: sauro <sauro@ztec.com.br>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: screensaver
In-Reply-To: <425EA253.7050907@ztec.com.br>
Message-ID: <Pine.LNX.4.61.0504141406080.26193@chaos.analogic.com>
References: <425EA253.7050907@ztec.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2005, sauro wrote:

> Greetings.
>
> I am using a 2.4 Linux workstation in text mode (no graphic interface).
> After some time, Linux activates the "screensaver" and the monitor goes blank 
> on "stand by" mode until activity is detected from the mouse or keyboard.
>
> Is it possible to disable this screensaver, so that the monitor keeps on all 
> the time?
>
> Thanks in advance.
>

Yes, but you need to send the screen some escape sequences, the
last time I checked. Subroutines included do the following:

noblank() Stops screen blanker (what you want).
scr()     Resets ANSI mode to return from shifted to normal.
           Sometimes the screen gets shifted after accidentally
           reading binary files.
cls()     Clear the screen.


//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//
//  This program may be distributed under the GNU Public License
//  version 2, as published by the Free Software Foundation, Inc.,
//  59 Temple Place, Suite 330 Boston, MA, 02111.
//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
static const char fix[]={27, '[', '3', 'g',
                          27, '[', 'H', 27, '[', 'H', 27, '[', 'H',
                          27, '[', 'H', 27, '[', 'H', 27, '[', 'H',
                          27, '[', 'H', 27, '[', 'H', 27, '[', 'H',
                          27, 'c', 27, ']', 'R' };
static const char blk[]={27, '[', '9', ';', '0', ']'};
static const char clr[]={27, '[', 'H', 27, '[', 'J' };
void noblank(int fd){ write(fd, blk, sizeof(blk)); }
void cls(int fd)    { write(fd, clr, sizeof(clr)); }
void scr(int fd)    { write(fd, fix, sizeof(fix)); }

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=



Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

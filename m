Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290333AbSA3SdX>; Wed, 30 Jan 2002 13:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290388AbSA3ScH>; Wed, 30 Jan 2002 13:32:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7301 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290422AbSA3Sbq>; Wed, 30 Jan 2002 13:31:46 -0500
Date: Wed, 30 Jan 2002 13:34:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dan Maas <dmaas@dcine.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP Speed
In-Reply-To: <00b501c1a9ba$93544830$1a01a8c0@allyourbase>
Message-ID: <Pine.LNX.3.95.1020130132830.16759A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Dan Maas wrote:

> > When I ping two linux machines on a private link, I get 0.1 ms delay.
> > When I send large TCP/IP stream data between them, I get almost
> > 10 megabytes per second on a 100-base link. Wonderful.
> > 
> > However, if I send 64 bytes from one machine and send it back, simple
> > TCP/IP strean connection, it takes 1 millisecond to get it back? There
> > seems to be some artifical delay somewhere.  How do I turn this OFF?
> 
> Stupid question - did you turn Nagle off?
> 
> int one = 1;
> setsockopt(fd, SOL_TCP, TCP_NDELAY, &one);
> 
> (I think; typing from memory...)
> 
> Regards,
> Dan
> 

I did, but I thought it was a TCP option, not a socket option.
I will change it and see if it does anything. Currently, it
seems like a no-op, no errors, but does nothing. 


Early in code:

int on = 1;

#define ON &on


Where accept is called. Returned socket value is set to nodelay. 

        len = sizeof(addr);
        if((hs = accept(s, SSAP &addr, &len))) == FAIL)
            ERRORS(Accept);
        if(setsockopt(hs, IPPROTO_TCP, TCP_NODELAY, ON, sizeof(on)) == FAIL)
            ERRORS(Setsockopt);



So, maybe it's supposed to be SOL_TCP?  I'll look for it.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.



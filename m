Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262105AbRENOnb>; Mon, 14 May 2001 10:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbRENOnV>; Mon, 14 May 2001 10:43:21 -0400
Received: from babel.spoiled.org ([212.84.234.227]:40271 "HELO
	babel.spoiled.org") by vger.kernel.org with SMTP id <S262105AbRENOnP>;
	Mon, 14 May 2001 10:43:15 -0400
Date: 14 May 2001 14:43:13 -0000
Message-ID: <20010514144313.984.qmail@babel.spoiled.org>
From: Juri Haberland <juri@koschikode.com>
To: andrewm@uow.edu.au (Andrew Morton)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c900 card and kernel 2.4.3 <
X-Newsgroups: spoiled.linux.kernel
In-Reply-To: <3AFFD5B1.82678220@uow.edu.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (OpenBSD/2.9 (i386))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Juri Haberland wrote:
>> 
>> Do you use 10Base2 (aka cheaper net)?
>> I do and after upgrading to 2.4.3 (I think) I had to force the driver to
>> use the BNC connector though the card was configured (via the little config
>> program supplied by 3com) to always use the BNC connector...
>> This way I lost several hours to figure out why it wasn't working anymore and
>> to discover that I have to build it as a module instead of having it compiled
>> into the kernel because I couldn't make it work with kernel options - only
>> with driver options...
>> Any suggestions?
> 
> Yes, sorry.
> 
> The problem with earlier kernels was that autoselection
> would notice the lack of 10baseT link beat and would then
> advance on to trying AUI/SQE/10base2/etc.  None of these
> interfaces allow the driver to know if there's anything
> connected and the driver consequently gets stuck on that
> interface.  The net effect: if you unplug the 10baseT
> the driver gets stuck and you have to reboot.
> 
> So autoselection was turned off if the NIC was found
> to have autonegotiation hardware.  If you want to use
> the other interfaces, you have to provide an option,
> as described in Documentation/networking/vortex.txt.

Actually I would expect the driver to use the default setting from
the EEPROM as it did before (or at least it seemed to me like that).

> For non-modular drivers things are less easy.  If you
> want to force it to use 10baseT (if_port zero) then
> it should work OK if you cheat and use mem_start=0x400.
> So `ether=0,0,0x400'.
> 
> For BNC, it should work just fine with `ether=0,0,1'.

According to vortex.txt it should be `ether=0,0,3'. I think I tried
that, but will do so again this evening.

> If it doesn't, please shout at me.   Compile the
> driver with `static int vortex_debug = 7;' at line
> 183 and send me the boot logs.

Thanks for answering,

Juri

-- 
Juri Haberland  <juri@koschikode.com> 


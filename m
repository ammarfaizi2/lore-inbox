Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318818AbSHWOw6>; Fri, 23 Aug 2002 10:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318835AbSHWOw6>; Fri, 23 Aug 2002 10:52:58 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:22409 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S318818AbSHWOw5>; Fri, 23 Aug 2002 10:52:57 -0400
Subject: Re: Linux 2.4.20-pre4-ac1 (this time regarding 2.5.31)
From: Steven Cole <elenstev@mesatop.com>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Alan Cox <alan@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208230826180.3234-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0208230826180.3234-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Aug 2002 08:53:07 -0600
Message-Id: <1030114387.4029.22.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-23 at 08:29, Thunder from the hill wrote:
> Hi,
> 
> On Sat, 24 Aug 2002, Eyal Lebedinsky wrote:
> > linux/drivers/usb/brlvger.c compile error
> > 
> > You would think that gcc, having had the same problem for a while,
> > would have smarted up by now. And they say computers are our
> > future...
> 
> Can't believe! In 2.5 we still use concatenation w/__FUNCTION__.
> 
> #define dbgprint(args...) \
>     ({ printk(KERN_DEBUG "Voyager: " __FUNCTION__ ": " args); \
>        printk("\n"); })
> 
> Shall we fix it?
> 
> #define dbgprint(args...) \
> 	printk(KERN_DEBUG "Voyager: %s: " args "\n", __FUNCTION__ );
> 
> should cut it, but
> 
> #define dbgprint(fmt, args...) \
> 	printk(KERN_DEBUG "Voyager: %s: " fmt "\n", __FUNCTION__ , args);
> 
> might be better.
> 
> 			Thunder

While you're at it, there are three other places you might want to 
take a look at:

[steven@spc9 linux-2.4.20-pre4-ac1]$ find . -name "*.c" | xargs grep -l "__, ##"
./drivers/video/aty128fb.c
./drivers/usb/brlvger.c
./drivers/ieee1394/sbp2.c
./arch/arm/mach-sa1100/system3.c

Steven



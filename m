Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbTAITHv>; Thu, 9 Jan 2003 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTAITHv>; Thu, 9 Jan 2003 14:07:51 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:59258 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266964AbTAITHl>; Thu, 9 Jan 2003 14:07:41 -0500
Date: Thu, 9 Jan 2003 14:16:18 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301091916.h09JGI228106@devserv.devel.redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: MB without keyboard controller / USB-only keyboard ?
In-Reply-To: <mailman.1042135501.3903.linux-kernel2news@redhat.com>
References: <20030109114247.211f7072.skraw@ithnet.com>    <1042134121.27796.20.camel@irongate.swansea.linux.org.uk>    <20030109183952.6be142fe.skraw@ithnet.com> <mailman.1042135501.3903.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > pc_keyb: controller jammed (0xFF)
>> > 
>> > Does your BIOS do keyboard emulation ?
>> 
>> It is Compaq EVO D510. It has merely nothing of interest in the BIOS (no
>> keyboard emu). As far as I remember it contains an I845 chipset.
> 
> Can you use the USB keyboard to configure the BIOS during boot. If so
> then it almost certainly has USB bios emulation. Another trivial test
> that would be useful is to stick a freedos boot floppy in the box and
> see if freedos works

I fail to see the point, Alan. Stephan's BIOS does exactly the
right thing: it emulates BIOS INTs which allow to read buffered
keystrokes, but it does not do SMM tricks to emulate port 0x60.
This is great, now pc_keyb.d must do detection right. It must
not loop endlessly if 0xff is returned from inb(). It's a bug.

-- Pete

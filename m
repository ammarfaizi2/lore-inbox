Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUCIQGC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 11:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUCIQGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 11:06:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:13199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262028AbUCIQFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 11:05:43 -0500
Date: Tue, 9 Mar 2004 08:04:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kliment Yanev <Kliment.Yanev@helsinki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-Id: <20040309080409.49fc0358.rddunlap@osdl.org>
In-Reply-To: <404DC622.7020300@helsinki.fi>
References: <40408852.8040608@helsinki.fi>
	<20040228104105.5a699d32.rddunlap@osdl.org>
	<40419A1C.5070103@helsinki.fi>
	<20040301101706.3a606d35.rddunlap@osdl.org>
	<404C8A35.3020308@helsinki.fi>
	<20040308090640.2d557f9e.rddunlap@osdl.org>
	<404CF77A.2050301@helsinki.fi>
	<20040308150907.4db68831.rddunlap@osdl.org>
	<404D0032.1000807@helsinki.fi>
	<20040308153602.331f079e.rddunlap@osdl.org>
	<404DC622.7020300@helsinki.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 15:26:58 +0200 Kliment Yanev wrote:

| 
| Randy.Dunlap wrote:
| |
| | I looked there but didn't see such symbols (using 'nm').
| | What did you use to see them?
| | The strings that I see all seem to contain 16-bit characters.
| 
| dhw.o, dap.o, dmgr.o and dcfg.o are located in nokia_cs.a, which does
| not include source. These are the parts that actually access the card
| and configure frequencies etc. They don't seem to be linked, since the
| dhw_* symbols are unknown in the module. Manually linking them with the
| .ko prevents it from being loaded (or maybe I am linking them wrong).
| They are defined in corresponding .h files mostly. I think that should
| handle all of them. nm sees the symbols in those .o files and in
| nokia_cs.a where they came from, but I haven't checked if all of them
| are there (I will do so soon). Note that nokia_cs.a is in the binary
| package where the firmware is. It is not the same as the firmware file
| (smac*.bin).
| 
| I am not at all familiar with kbuild (other than the driver porting
| howto) and actually have not even written c code before attempting this
| driver. Can you advise me on how to link external files like this into a
| .ko without breaking the module?

Not really, I've never done that.

| | | | You know, it's possible that you could purchase a card that already
| | | | works on Linux 2.6.... that might be a better solution than trying
| | | | to use an unknown binary module.
| |
| | Well, Sam Ravnborg did post a patch in the last week or so that
| | should help with (some) binary files...  probably .o and not .bin,
| | or maybe it doesn't matter.
| |
| 
| Clarify please. A patch to kbuild? Or to the kernel? Note that the .bin
| file is only the card firmware. No point looking in that for anything.
| The binary part of the _driver_ is in nokia_cs.a, which contains .o files.

A patch to kbuild (the kernel makefile system).

You would need to read Sam's emails about this to see how it works.

| | | At this point I am doing this just to see if it will work... I don't
| | | need the card for another week or so and if I don't get this one to work
| | | I'll just buy another one. Yet I have the feeling that this card will
| | | work before long... if only I could get those files linked that is...
| | |
| | | My makefile (dhw, dap, dmgr and dcfg are in the binary parts, present in
| | | the current dir as dhw.o etc.; all the others are .c files that get
| | | compiled during a make):
| | |
| | | ~    ifneq ($(KERNELRELEASE),)
| | | ~    obj-m       := nokia_c110.o
| | | ~    module-objs := dllc.o dtools.o dhw.o dap.o dmgr.o dcfg.o
| | |
| | | ~    else
| | | ~    KDIR        := /lib/modules/$(shell uname -r)/build
| | | ~    PWD         := $(shell pwd)
| | |
| | | ~    default:
| | | ~        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
| | | ~    endif
| 
| Can you tell me if the makefile is correct?

Sorry, I have no idea.

--
~Randy

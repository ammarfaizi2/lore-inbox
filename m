Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262159AbUCITdL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUCITar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:30:47 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:17426 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262135AbUCIT0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:26:10 -0500
Date: Tue, 9 Mar 2004 20:27:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kliment Yanev <Kliment.Yanev@helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
Message-ID: <20040309192713.GA2182@mars.ravnborg.org>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Kliment Yanev <Kliment.Yanev@helsinki.fi>,
	linux-kernel@vger.kernel.org
References: <40419A1C.5070103@helsinki.fi> <20040301101706.3a606d35.rddunlap@osdl.org> <404C8A35.3020308@helsinki.fi> <20040308090640.2d557f9e.rddunlap@osdl.org> <404CF77A.2050301@helsinki.fi> <20040308150907.4db68831.rddunlap@osdl.org> <404D0032.1000807@helsinki.fi> <20040308153602.331f079e.rddunlap@osdl.org> <404DC622.7020300@helsinki.fi> <20040309080409.49fc0358.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309080409.49fc0358.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 08:04:09AM -0800, Randy.Dunlap wrote:
> | 
> | dhw.o, dap.o, dmgr.o and dcfg.o are located in nokia_cs.a, which does
> | not include source. These are the parts that actually access the card
> | and configure frequencies etc. They don't seem to be linked, since the
> | dhw_* symbols are unknown in the module. Manually linking them with the
> | .ko prevents it from being loaded (or maybe I am linking them wrong).
> | They are defined in corresponding .h files mostly.
The above files are normal .o files, that should be linked in.
So what you do is to rename the above files to:
dhw.o_shipped
dap.o_shipped
dmgr.o_shipped
dcfg.o_shipped

And then in your makefile specify:

obj-m	:= cs110.o
cs110-y := dhw.o dap.o dmgr.o dcfg.o
cs110-y += <additional .o files compield from .c files>

Maybe you can specify the .a file direct replacing the four .o file - 
should work but I have not tried.

> | | Well, Sam Ravnborg did post a patch in the last week or so that
> | | should help with (some) binary files...  probably .o and not .bin,
> | | or maybe it doesn't matter.
That patch was crap - the _shipped functionality covers this nicely.

> | | | My makefile (dhw, dap, dmgr and dcfg are in the binary parts, present in
> | | | the current dir as dhw.o etc.; all the others are .c files that get
> | | | compiled during a make):
> | | |
> | | | ~    ifneq ($(KERNELRELEASE),)
> | | | ~    obj-m       := nokia_c110.o
> | | | ~    module-objs := dllc.o dtools.o dhw.o dap.o dmgr.o dcfg.o
Should be:   nokia_c110-y := dllc.o dtools.o dhw.o dap.o dmgr.o dcfg.o
See also example above.

> | | | ~    else
> | | | ~    KDIR        := /lib/modules/$(shell uname -r)/build
> | | | ~    PWD         := $(shell pwd)
> | | |
> | | | ~    default:
> | | | ~        $(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules
> | | | ~    endif
> | 
> | Can you tell me if the makefile is correct?
Looks OK except for the s/module/nokia_cs110/ point.

	Sam

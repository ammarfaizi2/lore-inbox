Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTGWDCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 23:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271086AbTGWDCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 23:02:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:26792 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271082AbTGWDCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 23:02:09 -0400
Date: Tue, 22 Jul 2003 20:14:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <yiding_wang@agilent.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 module loading issue
Message-Id: <20030722201432.6318fa73.rddunlap@osdl.org>
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D55220@axcs03.cos.agilent.com>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55220@axcs03.cos.agilent.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 16:27:24 -0600 <yiding_wang@agilent.com> wrote:

| I am still struggling on the fc driver module working on new 2.5.72/2.6 kernel and wish someone can shed some lights here.
| 
| The driver is working great for 2.4.x Linux and is modified to reflect all SCSI layer change in 2.5.72.  I have RH9.0 and installed 2.5.72 on the same system.  Driver compiled under 2.5.72 OK.  The module utilities are upgraded to 0.9.13-pre.
| 
| Now first problem I have is to module loading fails on "insmod mymodule.o".  Message:
|  
| "No module found in object"
| "Error inserting 'mymodule.o': -1 Invalid module format"
...
| 
| It looks like something is missing from migrating my driver module from 2.4.x to 2.5.x.
| 
| What is new requirement for module building and loading with "insmod" on 2.5.72 compare with the requirement in 2.4.x?  

Please use the correct makefile for mymodule.
See linux/Documentation/modules.txt and
  linux/Documentation/kbuild/makefile.txt.
In general, it only takes a few lines to build a module that is
maintained outside of the kernel source tree in 2.5/2.6.

Here is an example of one that is probably longer than it needs
to be:

# makefile for oops_test/dump*.c
# Randy Dunlap, 2003-03-12
# usage:
# cd /path/to/kernel/source && make SUBDIRS=/path/to/source/oops_test/ modules

CONFIG_OOPS_TEST=m

obj-m := dump_test.o

# dump_test-objs := dump_test.o

clean-files := *.o

# fini;

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

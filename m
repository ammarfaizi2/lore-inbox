Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbTGWGO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271110AbTGWGO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:14:58 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:20678 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S271122AbTGWGOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:14:53 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D55222@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: rddunlap@osdl.org, yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.72 module loading issue
Date: Wed, 23 Jul 2003 00:29:56 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks and I will definitely try it!

-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org]
Sent: Tuesday, July 22, 2003 8:15 PM
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 module loading issue


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

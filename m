Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271717AbTGXQ5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271721AbTGXQ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 12:57:11 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:46312 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S271717AbTGXQ4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 12:56:20 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D55226@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: rddunlap@osdl.org, yiding_wang@agilent.com, sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.72 module loading issue
Date: Thu, 24 Jul 2003 11:11:24 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

Thanks for the response.  I did not get time to look into this till now.  The way you suggested is to add module build process into kernel build.  This requires a user to build a loadable module with kernel together.  What I really want to is to have module build alone but include kernel symbols and variables so it will not have problem when loading.  The benefit of doing it is to make user and developer easy to change the code and rebuild without experiencing the kernel rebuild process every time.  I read those two documents and they mainly talking about how to build module with kernel together.

In2.4.x, there is a "Rules.make" which has all needed symbols and variables defined.  I just includes that file for my module build and everything works perfectly.  Now in 2.5.x, those structure has been changed and the "rule" files seem to be relocated under "scripts" and being changed too.  I am trying to make use of those "rules" to make module build and load simpler compare with build module with kernel each time.

Any ideas?

thanks and regards,

Eddie

> -----Original Message-----
> From: Randy.Dunlap [mailto:rddunlap@osdl.org]
> Sent: Tuesday, July 22, 2003 8:15 PM
> To: yiding_wang@agilent.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.5.72 module loading issue
> 
> 
> On Tue, 22 Jul 2003 16:27:24 -0600 <yiding_wang@agilent.com> wrote:
> 
> | I am still struggling on the fc driver module working on 
> new 2.5.72/2.6 kernel and wish someone can shed some lights here.
> | 
> | The driver is working great for 2.4.x Linux and is modified 
> to reflect all SCSI layer change in 2.5.72.  I have RH9.0 and 
> installed 2.5.72 on the same system.  Driver compiled under 
> 2.5.72 OK.  The module utilities are upgraded to 0.9.13-pre.
> | 
> | Now first problem I have is to module loading fails on 
> "insmod mymodule.o".  Message:
> |  
> | "No module found in object"
> | "Error inserting 'mymodule.o': -1 Invalid module format"
> ...
> | 
> | It looks like something is missing from migrating my driver 
> module from 2.4.x to 2.5.x.
> | 
> | What is new requirement for module building and loading 
> with "insmod" on 2.5.72 compare with the requirement in 2.4.x?  
> 
> Please use the correct makefile for mymodule.
> See linux/Documentation/modules.txt and
>   linux/Documentation/kbuild/makefile.txt.
> In general, it only takes a few lines to build a module that is
> maintained outside of the kernel source tree in 2.5/2.6.
> 
> Here is an example of one that is probably longer than it needs
> to be:
> 
> # makefile for oops_test/dump*.c
> # Randy Dunlap, 2003-03-12
> # usage:
> # cd /path/to/kernel/source && make 
> SUBDIRS=/path/to/source/oops_test/ modules
> 
> CONFIG_OOPS_TEST=m
> 
> obj-m := dump_test.o
> 
> # dump_test-objs := dump_test.o
> 
> clean-files := *.o
> 
> # fini;
> 
> --
> ~Randy
> | http://developer.osdl.org/rddunlap/ | 
http://www.xenotime.net/linux/ |
For Linux-2.6:
http://www.codemonkey.org.uk/post-halloween-2.5.txt
  or http://lwn.net/Articles/39901/
http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

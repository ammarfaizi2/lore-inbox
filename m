Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUGBSg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUGBSg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 14:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbUGBSg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 14:36:29 -0400
Received: from web40001.mail.yahoo.com ([66.218.78.19]:29009 "HELO
	web40001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264894AbUGBSgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 14:36:24 -0400
Message-ID: <20040702183623.74495.qmail@web40001.mail.yahoo.com>
Date: Fri, 2 Jul 2004 11:36:23 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: kbuild support to build one module with multiple separate components?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Folks

I'm puzzled by the kbuild system in 2.6 kernel.
I want to write a kernel module, which consists of
several components. The module is produced by
linking these components. These components are located
in separate subdirectories (for example A, B,C). 
Each component is generated also by linking 
multiple files. (For example, a_1.c, a_2.c for
building A.o, b_1.c, b_2.c for building B.o, then A.o
and B.o
should be linked to produce mymodule.o) 

I know if I put all the files in a single directory
The makefile of the module looks like

obj-$(CONFIG_MYMODULE) += mymodule.o
mymodule-objs := a_1.o a_2.o b_1.o b_2.o c_1.o c_2.o

It should work. But it is really messy, especially
there are a lot of files or each component requires
different EXTRA_CFLAGS. However, if I write
separate Makefiles for each component in their own
subdirectory, the Makefile of component A looks like

obj-y := A.o (or obj-$(CONFIG_MYMODULE) +=  A.o)
A-objs := a_1.o a_2.o

This is wrong, because kbuild will treat A as
independent module. All I want is to treat
A as component of the only module mymodule.o. It
should be linked to mymodule.o

Any idea on how to write a kbuild Makefile to
support such kind of single module produced
by linking multiple components and each component
is located in separate directory? Thanks.

-Song




		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail

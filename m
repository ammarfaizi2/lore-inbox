Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272124AbTG2Upz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272126AbTG2Upy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:45:54 -0400
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:34263 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S272124AbTG2Upi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:45:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: 2.5.x module make questions
Date: Tue, 29 Jul 2003 14:45:35 -0600
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D55239@axcs03.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.x module make questions
Thread-Index: AcNWEnMH6/C7q7DEEdeA3wBgsGgWXA==
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Team,

I have two questions regarding kbuild.
1, According to doc., makefile can do descending.  Could make carry ascending?
2, Does old style of makefile still work (it should according to the article of "Driver porting: compiling external module")?

I was using "make -C /usr/src/linux SUBDIRS=$PWD modules". Build process at the stage 2 after primary Makefile trying to get secondary Makefile to be involved.  I have fairly complicated source tree to be involved in the module build process, including descending and ascending.  The main (primary) Makefile is almost down to the bottom of the tree. It is in old style and has followng content:

export TOPDIR
export CFLAGS

all : ag.o

ag.o: ../../../../t/s/ts.o ../../../f/c/fc.o ../../../f/i/fi.o  s/sl.o 
	ld -r -o ag.o ../../../../t/s/ts.o ../../../f/c/fc.o ../../../f/i/fi.o s/sl.o 

../../../../t/s/ts.o:
	@echo "Making t-s"
	@make -C ../../../../t/s

../../../f/c/fc.o:
	@echo "Making F-C"
	@make -C ../../../f/c 

../../../f/i/fi.o:
	@echo "Making F-I"
	@make -C ../../../f/i

s/sl.o:
	@echo "Making linux s-l"
	@make -C s 

What happend is the linux make exits after excuting the above Makefile. It did not change the directory "@make -C **" and perform futher make.

At the end of tree, a Makefile is regular like (../../../f/c/Makefile):
T_INC = -I../../../t/api -I../../../t/s 
SL_INC = -I../../d/l/c
FC_INC = -I../i
TI_INC = -I../../d/api
INCLUDE_LOCAL = $(T_INC) $(SL_INC) $(FC_INC) $(TII_INC)

obj-m := fc.o

fc-objs := t1.o t2.o t3.o t4.o

EXTRA_CFLAGS := $(INCLUDE_LOCAL) -I$(TOPDIR)/drivers/scsi

Any suggestion is welcomed.  If the kbuild cannot do ascending, I have to change the source tree structure but that is the least I want to do.

Many thanks!

Eddie
 

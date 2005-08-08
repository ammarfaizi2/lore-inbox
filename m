Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVHHNC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVHHNC5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbVHHNC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:02:57 -0400
Received: from web60517.mail.yahoo.com ([209.73.178.165]:21405 "HELO
	web60517.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750854AbVHHNC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:02:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MFMsTkbBDwYbvjJCGSGIhedMoiPaywU8DIAvi6evQtDY+fzurN4kAdWaByWp1+qOmk+NP/8vdb8ZCTRSouty+ZjlgFPETzaHi7j4nVdIz03w86jMSNTOpnQQtRa/Z5QfzDkyK92XTPeijGgXOK+wvi8VHW0Xvmazb93iq6tq+xw=  ;
Message-ID: <20050808130246.58431.qmail@web60517.mail.yahoo.com>
Date: Mon, 8 Aug 2005 06:02:46 -0700 (PDT)
From: mhb <badrpayam@yahoo.com>
Subject: I can not  build a new kernel image with a assembly module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I had added an assembly program to the networking
section of kernel linux 2.2.16 without any problem.
But when I add it to kerenel 2.4.1 I could build that
kernel, but I faced with kernel panic error when I
boot
system with new builded image. I use the following
Make file to build It in the 2.4.1 kernel. 

/*--------------------------------*/
L_TARGET := libtest.a

obj-$(CONFIG_TEST)		+= test.o

override CFLAGS += -Wpointer-arith
override CFLAGS += -Wbad-function-cast
override CFLAGS += -DTERMIO


#-----------------------------------------------------------------------------
# Section 3 - Conversion routines from new style to
old style for Rules.make

#-----------------------------------------------------------------------------
# Section 4 - Rules.make section
include $(TOPDIR)/Rules.make
#-----------------------------------------------------------------------------
# Section 5

$(obj-y):  $(TOPDIR)/include/linux/config.h\
                       
$(TOPDIR)/include/linux/autoconf.h

clean:
	-rm -f *.o
tags:
	ctags libtest.a

tar:
	tar -cvf /dev/f1 .

test.o: test1.o test2.o test3.o 
	$(LD) -r -o $@ test1.o test2.o test3.o 

test3.o: test3.s
	$(AS) -o $@ $<
#-----------------------------------------------------------------------------
As you can see test3.s is an assembly file.
I guess this problem is related to this Makefile.
Is this Make file true?
How can I win over this problem?

thanks

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

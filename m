Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTA0Tfp>; Mon, 27 Jan 2003 14:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbTA0Tfp>; Mon, 27 Jan 2003 14:35:45 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:63177 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S266977AbTA0Tfo>; Mon, 27 Jan 2003 14:35:44 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: no version magic, tainting kernel.
Date: 27 Jan 2003 20:54:41 +0100
Organization: SuSE Labs, Berlin
Message-ID: <873cneid1a.fsf@bytesex.org>
References: <200301231459.22789.schlicht@uni-mannheim.de> <20030127185228.GA8820@p3.attbi.com>
NNTP-Posting-Host: localhost
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: bytesex.org 1043697281 12504 127.0.0.1 (27 Jan 2003 19:54:41 GMT)
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry Cooperstein <coop@axian.com> writes:

> is fine, but you have to have a Makefile in the current directory,
> and that Makefile needs a somewhat different form for 2.4 and
> 2.5 kernels.

It is no problem to use the same Makefile for both 2.4.x and 2.5.x,
and even let the Makefile do the RightThing[tm] in case the user just
types 'make'.  My Makefiles for kernel stuff look like this (stripped
down a bit):

==============================[ cut here ]==============================

ifneq ($(KERNELRELEASE),)
# call from kernel build system

obj-m	:= btaudio.o

-include $(TOPDIR)/Rules.make

else

KDIR	:= /lib/modules/$(shell uname -r)/build
PWD	:= $(shell pwd)

default:
	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) modules

endif

==============================[ cut here ]==============================

If you need different stuff for 2.4.x and 2.5.x you can handle it
using ifeq ($(VERSION).$(PATCHLEVEL),2.4)

  Gerd

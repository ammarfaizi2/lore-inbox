Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWHQHtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWHQHtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHQHtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:49:32 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:13980 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932207AbWHQHtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:49:32 -0400
Date: Thu, 17 Aug 2006 09:47:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: 7eggert@gmx.de, clowncoder <clowncoder@clowncode.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New version of ClownToolKit
In-Reply-To: <20060817044228.GA16320@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0608170945410.16217@yvahk01.tjqt.qr>
References: <6Kxx5-7PT-7@gated-at.bofh.it> <6KyCM-1w7-1@gated-at.bofh.it>
 <E1GDUcG-00016M-Nu@be1.lrz> <20060817044228.GA16320@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > LIBDIR=/lib/modules/`uname -r`
>> > make -C $LIBDIR/source O=$LIBDIR/build SUBDIRS=`pwd` modules
>> > 
>> > For a normal kernel installation this will do the right thing.
>> > source points to the kernel source and build point to the output
>> > directory (they are often equal but not always).
>> 
>> Please don't tell module authors to unconditionally use `uname -r`.
>> I frequently build kernels for differentd hosts, and if I don't, I'll
>> certainly compile the needed modules before installing the kernel.
>> Therefore /lib/modules/`uname -r` is most certainly the completely
>> wrong place to look for the kernel source.
>
>/lib/modules/`uname -r` is the general solution that works for most
>people and should be at least default. It is certainly better than
>/usr/src/linux.
>But yes they better make it override able.

In some outoftree modules of mine, the Makefile reads like this

MODULES_DIR := /lib/modules/$(shell uname -r)
KSRC_DIR    := ${MODULES_DIR}/source
KOBJ_DIR    := ${MODULES_DIR}/build

all: modules
modules:
	make -C "${KOBJ_DIR}" M="$$PWD";

and one can easily override it by calling `make MODULES_DIR=/foo/bar` 
(instead of just `make`).


Jan Engelhardt
-- 

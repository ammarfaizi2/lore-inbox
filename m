Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbTATUIf>; Mon, 20 Jan 2003 15:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTATUIf>; Mon, 20 Jan 2003 15:08:35 -0500
Received: from quechua.inka.de ([193.197.184.2]:37523 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S266810AbTATUIe>;
	Mon, 20 Jan 2003 15:08:34 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
References: <25160.1042809144@passion.cambridge.redhat.com> <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il> <E18a1aZ-0006mL-00@bigred.inka.de> <20030119001256.GA11575@compsoc.man.ac.uk> <E18aEyl-0006O0-00@bigred.inka.de> <20030119182250.GA1495@mars.ravnborg.org>
Organization: private Linux site, southern Germany
Date: Mon, 20 Jan 2003 21:14:17 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18aiJF-000344-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is a bug that the current Makefile can't compile modules in an
> > object directory different from the source directory. This means the
> > module source tree can't be mounted read-only (again, without
> > resorting to symlinks).
>
> make -C path/to/kernel/src SUBDIRS=$PWD modules
> So simple when you know the trick. That what I have documented

no, this doesn't work when you have the source and object files _of
the module_ in separate directories. You'd have to run make in the
object directory, but there seems no way to tell it where the source
is. (At least I have not found any.)

The reason to do this is compiling one module for different kernel
configurations as well as compiling one kernel for different
configurations. I.e. I want to have a tree like this:

first the kernel:

/usr/src/linux/2.5.99/              this is directory X
/var/obj/linux/2.5.99/boxa          here is X compiled for boxa
/var/obj/linux/2.5.99/boxb          here is X compiled for boxb

(this doesn't work either at the moment, another bug/missing feature...)

then the external module:

/usr/src/cipe                       this is directory Y
/var/obj/cipe/2.5.99/boxa           here is Y compiled against X for boxa
/var/obj/cipe/2.5.99/boxb           here is Y compiled against X for boxb

and /usr/src might be mounted read-only.

Olaf


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTB0MEf>; Thu, 27 Feb 2003 07:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTB0MEf>; Thu, 27 Feb 2003 07:04:35 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:3602 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264730AbTB0MEe>; Thu, 27 Feb 2003 07:04:34 -0500
Message-Id: <200302271206.h1RC6Rs29598@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mike Hayward <hayward@loup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 corrupt file system, 2.4.20 Makefile problem
Date: Thu, 27 Feb 2003 14:03:24 +0200
X-Mailer: KMail [version 1.3.2]
References: <200302270513.h1R5DcG23996@flux.loup.net>
In-Reply-To: <200302270513.h1R5DcG23996@flux.loup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2003 07:13, Mike Hayward wrote:
> I've been running 2.4.19 for quite awhile, but today it locked up,
> had to be hard rebooted, and trashed my ext3 file system.  Something
> about a seemingly infinite number of Duplicate/Bad Blocks from fsck
> even though the hard drive is fine.  I assumed with the journal the
> file system would be rock solid, but ...  I'm hoping 2.4.20 proves
> more stable; has anyone else seen 2.4.19 trash the hard drive?

Journalling saves you from data loss due to abrupt power off.
No filesystem will ever save you from silent data corruption
due to failing hardware or from bugs in filesystem code itself.

> 2.4.20 doesn't build on my RH7.2 box which uses gcc 2.96 due to a mod
> to the Makefile which I just undid and subsequently compiled just
> fine.  Without said line, stdarg.h (which isn't part of the linux
> kernel includes) is not found since -nostdinc probably removes *all*
> include directories not explicitly specified, including:
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/include
>
> ---New make line---
> kbuild_2_4_nostdinc    := -nostdinc -iwithprefix include
>
> ---Old make line---
> kbuild_2_4_nostdinc     := -nostdinc $(shell $(CC) -print-search-dirs
>
> | sed -ne 's/install: \(.*\)/-I \1include/gp')
>
> If stdarg.h doesn't belong in the kernel distribution, perhaps the
> configure or make process could do some checking to make sure the
> appropriate include directory for stdarg.h is included in that
> variable?

IIRC this can happen if your gcc is in non-standard location.
Curiously, it will work just fine for 99,9% of other source packages,
but not the kernel.

Instead of playing with makefiles I got away with:

GCC_EXEC_PREFIX=/path/to/gcc-3.2/lib/gcc-lib make ....
--
vda

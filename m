Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUBTNFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 08:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUBTNF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 08:05:26 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:32907 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S261244AbUBTNER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 08:04:17 -0500
Date: Fri, 20 Feb 2004 14:03:06 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: yiding_wang@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still have build error on 2.6.2 fc/proc/array.c
Message-ID: <20040220130306.GA11351@localhost>
References: <0A78D025ACD7C24F84BD52449D8505A15A80D4@wcosmb01.cos.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0A78D025ACD7C24F84BD52449D8505A15A80D4@wcosmb01.cos.agilent.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 17th yiding_wang@agilent.com wrote:

> Based on README and requirement of Changes in linux-2.6.2, I have updated needed utilities and other files with the following:
> binnutils 2.14
> e2fsprogs-1.34
> module-init-tools-3.0-pre10
> procps 3.1.15
> 
> Everything is installed OK.
> 
> Then compiling new 2.6.2 kernel still fails wi the following.  What is the upgrade file for this problem?

Your kernel sources and all the mentioned tools are now OK, and probably
were OK already. The only thing that is giving you the error is the
version of the gcc compiler that you use (2.96).

> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      fs/proc/array.o
> fs/proc/array.c: In function `proc_pid_stat':
> fs/proc/array.c:398: Unrecognizable insn:
> (insn/i 727 1015 1009 (parallel[ 
> ...

It is the *compiler* (gcc-2.96) that has a bug here. As this version of
gcc has many other bugs developers no longer work around difficulties
this specific version of gcc has.

What you can do is upgrade your gcc package to a later version (3.2.x or
3.3.x or even later from your distribution). As a workaround I've made a
little patch that you can apply to fs/proc/array.c if you still want to
keep using gcc 2.96 for a little while. It's archived here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107567013416122&w=2
-- 
Marco Roeland

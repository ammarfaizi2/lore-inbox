Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUA2JYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUA2JYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:24:31 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:59559 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S263523AbUA2JYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:24:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>,
       Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Subject: Re: long long on 32-bit machines
Date: Thu, 29 Jan 2004 10:19:22 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200401282051.VAA07809@faui1d.informatik.uni-erlangen.de> <40186338.3010005@zytor.com>
In-Reply-To: <40186338.3010005@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401291019.22813.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 January 2004 02:34, H. Peter Anvin wrote:

> If I remember correctly, a 6-argument system call on s390 will put a
> pointer to the last two arguments as the effective 5th argument, so this
> would not affect the system call calling convention, correct?

Almost. I think this is only relevant for mmap2(), where we pass a single
pointer to a struct with all six arguments, but the result is the same.

I don't know where I got the misinformation about the register pairs
on s390, but I verified that the problem exists on MIPS and PowerPC.
See sys32_ftruncate64 in arch/mips/kernel/linux32.c and 
arch/ppc64/kernel/sys_ppc32.c. PA-RISC appearantly work around this
by defining their own system call handlers with separate high/low
arguments, so they effectively work like i386 and s390. 

	Arnd <><


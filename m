Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbTDRTMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 15:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTDRTMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 15:12:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18438 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263217AbTDRTMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 15:12:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [TRIVIAL] kstrdup
Date: 18 Apr 2003 12:24:09 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7pjcp$j8h$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com> <3EA02E55.80103@pobox.com> <Pine.LNX.4.53.0304181323400.22493@chaos> <3EA0469D.7090602@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3EA0469D.7090602@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
> 
> That's kinda cute.  Why not submit a patch to the strcpy implementation 
> in include/asm-i386/string.h?  :)  Ours is shorter, but does have a jump:
>          "1:\tlodsb\n\t"
>          "stosb\n\t"
>          "testb %%al,%%al\n\t"
>          "jne 1b"
> 
> Which is better?  I don't know; I'm still learning the performance 
> eccentricities of x86 insns on various processors.
> 

It varies from porocessor to processor, and also depends on usage.

> 
> Related x86 question:  if the memory buffer is not dword-aligned, is 
> 'rep movsl' the best idea?  On RISC it's usually smarter to unroll the 
> head of the loop to avoid unaligned accesses; but from reading x86 asm 
> code in the kernel, nobody seems to care about that.  Is the 
> unaligned-access penalty so small that the increased code size of the 
> head-unroll is never worth it?
> 

A lot of the newer x86 processors will perform this unrolling in
microcode.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318814AbSHRD0O>; Sat, 17 Aug 2002 23:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318815AbSHRD0O>; Sat, 17 Aug 2002 23:26:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10765 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318814AbSHRD0N>; Sat, 17 Aug 2002 23:26:13 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Boot failure in 2.5.31 BK with new TLS patch
Date: 17 Aug 2002 20:29:51 -0700
Organization: Transmeta Corporation
Message-ID: <ajn4bf$c2r$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0208171134070.3169-100000@home.transmeta.com> <Pine.LNX.4.44.0208172051280.17227-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44.0208172051280.17227-100000@localhost.localdomain>,
Ingo Molnar  <mingo@elte.hu> wrote:
>
>oh, setup.S. nasty indeed. (yet) untested patch attached, booting into the
>new kernel shortly.

Ingo, this only fixes the gdt size, it doesn't fix the fact that the gdt
itself doesn't seem to be aligned at all (and to clarify, I'm talking
very much about the boot-time entry.S gdt, not the "real" run-time gdt). 

Mind doing that part too?

(I can well imagine that some CPU's may not even have the low 4 bits of
the gdt register wired up at all, since they should always be zero. So
doing a lgdt or lidt with the base not being 16-byte aligned could well
result in basically loading crap into the LDT, causing the system not to
work at all).

This is also true of "bootsect_gdt", I think. Altough I have no idea
what the bios "int 15" interfaces actually do.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTIMX5t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTIMX5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:57:49 -0400
Received: from zero.aec.at ([193.170.194.10]:8966 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262265AbTIMX5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:57:47 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, jh@suse.cz
Subject: stack alignment in the kernel was Re: nasm over gas?
From: Andi Kleen <ak@muc.de>
Date: Sun, 14 Sep 2003 01:57:25 +0200
In-Reply-To: <vog2.7k4.23@gated-at.bofh.it> (Jamie Lokier's message of "Sat,
 13 Sep 2003 21:30:18 +0200")
Message-ID: <m31xuk8cnu.fsf_-_@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <rZQN.83u.21@gated-at.bofh.it> <uw6d.3hD.35@gated-at.bofh.it>
	<uxED.5Rz.9@gated-at.bofh.it> <uYbM.26o.3@gated-at.bofh.it>
	<uZUr.4QR.25@gated-at.bofh.it> <v4qU.3h1.27@gated-at.bofh.it>
	<vog2.7k4.23@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Obvious the _intent_ of -O2 is to compile for speed, but it's clear
> that GCC often emits trivially redundant instructions (like stack
> adjustments) that don't serve to speed up the program at all.

The stack adjustments are for getting good performance with floating
point code. Most x86 CPUs require 16 byte alignment for floating point
stores/loads on the stack. It can make a dramatic difference in some 
FP intensive programs.

But obviously that's completely useless for the kernel which never
uses floating point.

A compiler option to turn it off would make sense to save .text space
and eliminate these useless instructions. Especially since the kernel
entry points make no attempt to align the stack to 16 byte anyways,
so most likely the stack adjustments do not even work.

(this option could also warn for floating point usage which is usually illegal,
although you can already get the same effect by compiling with -msoft-float)

-Andi

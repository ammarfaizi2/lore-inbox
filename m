Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbULPUhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbULPUhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbULPUha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:37:30 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:7894 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261970AbULPUhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:37:25 -0500
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea 
In-reply-to: Your message of "Thu, 16 Dec 2004 15:28:24 +0100."
             <20041216142824.GC29761@wotan.suse.de> 
Date: Thu, 16 Dec 2004 20:37:11 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1Cf2N5-0005pD-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There are so many problems in snooping and decoding instructions it
> > isn't funny. Aside from the mmap pci buffer half way through instruction
> 
> Hmm? From what I remember reading the code of the Xen hypervisor
> they are already emulating a lot of instructions (e.g. take a look
> at xen/arch/x86/x86_32/seg_fixup.c) Emulating some more doesn't 
> seem like a big issue to me.

There's actually no emulation in Xen at all. seg_fixup is the
closest we come, which is a tiny decoder that is able to work out
the effective address of an instruction. It's only through grim
necessity we need this in order to be able to make NPTL thread
local storage accesses work (-ve segment offsets). We'd much
prefer that glibc was slightly tweaked such that we didn't have
to do this (it would be a lot faster too).

Anyhow, I really don't think emulation is the issue. The handful
of cases that you pointed out that could relatively easily be
emulated constitute a tiny fraction of the arch xen patch.  Even
so, you have to be a bit careful from a performance point of
view: loading debug registers can occur quite frequently, and its
much quicker to be able to load them as a batch rather than
taking individual faults. 


Ian

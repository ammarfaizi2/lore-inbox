Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbUAJR0a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUAJR0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:26:30 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:24202 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265227AbUAJR02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:26:28 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 10 Jan 2004 09:26:27 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] First patch to improve ELF sanity checks
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC0752714F@difpst1a.dif.dk>
Message-ID: <Pine.LNX.4.44.0401100912590.1798-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Jesper Juhl wrote:

> 
> Hi,
> 
> Andrew, please consider including the patch below in -mm for testing.
> The patch works nicely here, but broader testing and review would be good.
> An explanation of the patch can be found below.
> 
> This is only a first version, and it does not yet check all I want it to,
> but the checks it does add should be valid. As far as I've been able to
> tell, the checks it makes are valid according to the ELF spec, and it does
> not seem to break anything. I'm currently using it on my own box and I
> have not yet seen a single binary fail to load - I've also been testing by
> modifying a valid ELF binary to contain invalid info in the fields that
> are checked, and all my test-cases fail as expected.
> 
> This patch /should/ work on all archs. It adds a check to asm-i386/elf.h
> that I've not added to any other archs for the simple reason that I don't
> know what a valid check would be on anything but x86 32 bit atm, but I'll
> be looking into that, and the additional check for i386 should not harm
> other archs - their checking will just be a little weaker than i386.
> 
> So far I've only added these checks to load_elf_binary , but Jakub pointed
> out to me that they would need to go into load_elf_interp as well. I will
> add the checks there as well as soon as I convince myself that they really
> are needed there. So far I only see load_elf_binary calling
> load_elf_interp, and since load_elf_binary does the checks and abort if
> they fail before calling load_elf_interp I don't (yet) see why they would
> be needed there as well. I'm sure Jakub is probably right, and I'm looking

You do not have to convince yourself, trust Jakub ;) The checks are needed 
even inside load_elf_interp since they refer to two different images. You 
might also want to create a separate function that does the checks and 
call it from both load_elf_interp and load_elf_binary.



- Davide






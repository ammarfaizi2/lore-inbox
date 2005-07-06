Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVGGAXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVGGAXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVGFUCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:02:35 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:30733 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261156AbVGFRXS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:23:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WqQydwPlNUz27cUkrmOyWYG37PKjXCrYrqw2Xc17dHBXT5ZK7Y2wRjFZBohvlW/7bvcx7qq3ntm1a/1d6l0YlB1P7ypFfaKpZphDqwY7HjnyOI1z2GY4/Z+smajJtkgLhyi8zTSUK56FUY65kgHrFywANU1YO+5r1KBUtLg5r1A=
Message-ID: <100bdf0005070610231ce9067@mail.gmail.com>
Date: Wed, 6 Jul 2005 19:23:16 +0200
From: Khalfallah Karim <aurelyen.tomp@gmail.com>
Reply-To: Khalfallah Karim <aurelyen.tomp@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.6.6 crash on Leon2-MMU (while init loads ELF busybox)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In brief:
=========
	While booting Snapgear-Linux-2.6.6 on Leon2-MMU,
	crash of IU due to an unresolved virtual address
	of the 1st ELF binary launched by init process
	(it is actually in kernel mode, not in user mode yet)
In detail:
==========
	The situation:
		When the init process is getting ready to load the
		Busybox (which is in ELF format), probably to do a
		mount, the system wants to clear its bss section.
		So there's a call made to padzero() (coded in file
		<fs/binfmt_elf.c>) with an argument 'elf_bss' which
		equals the virtual base address of .bss.
		Currently I am using ROMfs, for I still can't handle
		non-versatile memory on my board (I mean at a hardware
		level).
	The trouble:
		When padzero() attempts to clear the first word of the
		.bss section, the virtual address does not seem to have
		been previously "MMU-resolved" by the system. Therefore,
		it crashes the IU.
	My questions:
		Q1: Has anyone any idea why the MMU has not been settled
		yet at the time the system attempts to clear the .bss
		section ?
		Q2: I should get an exception trap for accessing a 'bad'
		virtual address (I'm on Sparc) - why do the machine gets
		straight in IU error mode ?	

I have not registered yet to <lkml.org>, so please CC'me if you intend
to answer.

Thank you a lot,
Aurelyen.

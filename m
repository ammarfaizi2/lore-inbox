Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTBIAqh>; Sat, 8 Feb 2003 19:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTBIAqh>; Sat, 8 Feb 2003 19:46:37 -0500
Received: from ns.suse.de ([213.95.15.193]:15370 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267135AbTBIAqh>;
	Sat, 8 Feb 2003 19:46:37 -0500
Date: Sun, 9 Feb 2003 01:56:19 +0100
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@suse.cz>,
       Kevin Lawton <kevinlawton2001@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in arch/i386/kernel/process.c for reloading of debug registers (DRx)?
Message-ID: <20030209005618.GA12369@wotan.suse.de>
References: <20030203235140.10443.qmail@web80304.mail.yahoo.com.suse.lists.linux.kernel> <p7365s0ri9c.fsf@oldwotan.suse.de> <20030207163301.GH345@elf.ucw.cz> <20030208172204.GA24577@wotan.suse.de> <20030208193149.GA9720@bjl1.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030208193149.GA9720@bjl1.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	- However, DR6 bit B0 is now set.

You cannot detect it. Linux offers no way to read DR6 from user space
as far as I can see. The only way to handle break points is to catch
the signals caused by the debug exceptions.

Yo access debug registers you need to use ptrace from another process.
ptrace only ever returns cached values in tsk->thread, but the register is 
never stored in there.

So in fact __switch_to could drop the loaddebug(next, 6) because it is 
useless.

-Andi

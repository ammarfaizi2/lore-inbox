Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbSLIUOi>; Mon, 9 Dec 2002 15:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSLIUOi>; Mon, 9 Dec 2002 15:14:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29840 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266160AbSLIUOh>;
	Mon, 9 Dec 2002 15:14:37 -0500
Date: Mon, 09 Dec 2002 12:18:29 -0800 (PST)
Message-Id: <20021209.121829.34992912.davem@redhat.com>
To: schwidefsky@de.ibm.com
Cc: torvalds@transmeta.com, dan@debian.org, george@mvista.com,
       jim.houston@ccur.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFC1954F5C.20E78677-ONC1256C8A.005E887F@de.ibm.com>
References: <OFC1954F5C.20E78677-ONC1256C8A.005E887F@de.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
   Date: Mon, 9 Dec 2002 18:16:43 +0100
   
   >Architecture maintainers, can you comment on how easy/hard it is to do the
   >same thing on your architectures? I _assume_ it's trivial (akin to the
   >three-liner register state change in i386/kernel/signal.c).
   
   For s390/s390x this is actually quite tricky. The system call number is
   coded in the instruction, e.g. 0x0aa2 is svc 162 or sys_nanosleep. There
   is no register involved that contains the system call number I could
   simply change. I either have to change the instruction (no way) or I
   have to avoid going back to userspace in this case. This would require
   assembler magic in entry.S. Not nice.

Put the magic restart_block syscall at some fixed place in every
user process, change the PC to that.  Or, alternatively, put the
restart_block syscall insn on the stack and point the PC at that.

This isn't rocket science :-)


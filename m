Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSJIMLE>; Wed, 9 Oct 2002 08:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261589AbSJIMLD>; Wed, 9 Oct 2002 08:11:03 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:5649 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261582AbSJIMLC>;
	Wed, 9 Oct 2002 08:11:02 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: i386 kallsyms section is in the wrong place
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Oct 2002 22:16:33 +1000
Message-ID: <12959.1034165793@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resend, the original has not appear in l-k archives.  Did we lose a
chunk of l-k today?

The kallsyms section in arch/i386/vmlinux.lds.S is in the wrong place.
kallsyms data is read only, it should be with the rest of the read only
sections like .rodata, .kstrtab, __ex_table, __ksymtab etc.  Making it
separate increases memory use for small systems (embedded machines can
keep read only data in ROM) and slows down large systems (NUMA boxes
can replicate read only data and text on each node for faster access).
The placement of kallsyms in kdb was done for very good reasons.

Congratulations, you managed to take working kdb code and introduce
multiple errors over three kernel releases, and it is still not
correct!


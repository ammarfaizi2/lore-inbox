Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129721AbQJaQE1>; Tue, 31 Oct 2000 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQJaQER>; Tue, 31 Oct 2000 11:04:17 -0500
Received: from styx.cs.kuleuven.ac.be ([134.58.40.3]:28821 "EHLO
	styx.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S129713AbQJaQEG>; Tue, 31 Oct 2000 11:04:06 -0500
Date: Tue, 31 Oct 2000 16:48:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: vma->vm_end > 0x60000000
Message-ID: <Pine.LNX.4.10.10010311645420.400-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In fs/proc/array.c:proc_pid_statm() there is this test block:

    if (vma->vm_flags & VM_EXECUTABLE)
	    trs += pages;   /* text */
    else if (vma->vm_flags & VM_GROWSDOWN)
	    drs += pages;   /* stack */
    else if (vma->vm_end > 0x60000000)
	    lrs += pages;   /* library */
    else
	    drs += pages;

Is there any special reason for the hardcoded constant `0x60000000'?

In the Linux/m68k tree, we use TASK_UNMAPPED_BASE instead. But I don't know
why.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136243AbRAGS0I>; Sun, 7 Jan 2001 13:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136299AbRAGSZ6>; Sun, 7 Jan 2001 13:25:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:44774 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136257AbRAGSZn>;
	Sun, 7 Jan 2001 13:25:43 -0500
Message-Id: <5.0.0.25.0.20010107190604.00a44400@195.117.13.2>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Sun, 07 Jan 2001 19:21:08 +0100
To: linux-kernel@vger.kernel.org
From: Blizbor <tb670725@ima.pl>
Subject: Bug in 2.2 kernels (mysterious hangs after freeing unused
  memory)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have found something weird in kernel 2.2.17.
After installation on the Pentium PRO equipped machine,
I have moved hard disk to another one, but equipped
with AMD-K5 and after encountering problems I moved again
this disk to machine equipped with Intel Pentium MMX.

On all machines except Pentium PRO boot process was stopping
after freeing unused kernel memory.

I've made some steps (incl. simple kernel source modification)
to find why. It was mysterious for me why even "init=/bin/bash"
option doesn't help.
I have found that read_exec is done three times at start on good machine,
and only once on bad. This inspired me to issue "init=/sbin/sash" to
kernel. And bingo !. System was booted.
Next - each try to start something using shared libraries was fault.
Problem was: signal 4 due to glibc was compiled for i686 (f...d RH7,
automated like windows)

My conclusion is: kernel doesnt handle situations when "init" process
dies.

I was'nt tested this on 2.4 series kernel.

.
________________________________________________
Nie ma zlecen niemozliwych do zrealizowania. Sa tylko trudne, bardzo trudne
i takie za ktore klient nie bedzie w stanie zaplacic.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

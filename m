Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129724AbQLDV57>; Mon, 4 Dec 2000 16:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLDV5t>; Mon, 4 Dec 2000 16:57:49 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:39942 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129724AbQLDV5n>; Mon, 4 Dec 2000 16:57:43 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Mon, 4 Dec 2000 14:27:10 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
MIME-Version: 1.0
Message-Id: <00120414271000.01254@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I have the cs46xx driver compiled either as a module or into
the kernel, then 2.4.0-test12-pre4 locks up when KDE 2.0
is started.

The problem with dummy.o in 2.4.0-test12-pre4 allowed me
to find the possible source of this lock-up which I have been
seeing recently (since test11-ac2) while starting up KDE 2.0.

This morning, I tried out 2.4.0-test12-pre4, and KDE 2.0
started up (and there was much rejoicing). Of course, I
saw the error when I tried to make modules, but I thought
could live without sound for one bootup.

Then I applied Mohammad A. Haque's small patch to
linux/include/linux/module.h, recompiled , and the system
froze again at the same spot ("Loading the panel")
while starting up KDE 2.0.

I found that if I said N for the cs46xx sound driver, then I
get a 2.4.0-test12-pre4 kernel that will run KDE 2.0,
sans sound :(.

I can run GNOME with 2.4.0-test12-pre4 with
cs46xx compiled as a module or compiled into the kernel, 
and everything works just fine.

Here is some additional information from /var/log/messages:
2.4.0-test10 works OK with KDE 2.0 and sound.

For 2.4.0-test12-pre4:

Crystal 4280/461x + AC97 Audio, version 0.14, 13:39:25 Dec  4 2000
cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)

For 2.4.0-test10:

Crystal 4280/461x + AC97 Audio, version 0.09, 15:31:37 Nov  1 2000
cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
cs461x: Unknown card (1028:0096) at 0xf8ffe000/0xf8e00000, IRQ 18
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)

The hardware is a DELL 420 dual P-III.
The base linux distro is Linux-Mandrake 7.2.
Filesystems are ReiserFS, running reiserfs-3.6.19 for test12
and reiserfs-3.6.18 for test10.

Note: The ReiserFS folks looked at this, but could
not reproduce this on another smp machine. That
was before I noticed the connection with cs46xx.

When I say the system freezes, I mean it completely locks up, and
ALT-SYSRQ-<whatevercommand> does not do a thing.  The magic
key combo gives the expected result before freezup.

Thanks in advance for any help,

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

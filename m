Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbRE0RZ7>; Sun, 27 May 2001 13:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262832AbRE0RZt>; Sun, 27 May 2001 13:25:49 -0400
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:61422
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S262829AbRE0RZj>; Sun, 27 May 2001 13:25:39 -0400
Date: Sun, 27 May 2001 19:25:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@mimas.fachschaften.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: Inconsistent "#ifdef __KERNEL__" on different architectures
Message-ID: <Pine.NEB.4.33.0105271903050.4227-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while looking for the reason of a build failure of the ALSA libraries on
ARM [1] I discovered the following strange thing:

On some architectures a function is inside an "#ifdef __KERNEL__" in the
header file and on others not. Is there a reason for this or is this
inconsistency simply a bug?

In this case the following functions are affected (in 2.4.5):

atomic_read, atomic_inc and atomic_dec in include/asm-*/atomic.h

"#ifdef __KERNEL__" only on arm, mips, mips64 and sparc (but not on
                                                         sparc64)


rmb and wmb in include/asm-*/system.h

"#ifdef __KERNEL__" only on arm and sparc (but not on sparc64)

not defined on parisc although used to define smp_rmb on SMP systems:
<--  snip  -->
#ifdef CONFIG_SMP
#define smp_mb()        mb()
#define smp_rmb()       rmb()
#define smp_wmb()       wmb()
#else
<--  snip  -->


cu
Adrian

[1] http://bugs.debian.org/97988


-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi


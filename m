Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAaWNH>; Wed, 31 Jan 2001 17:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbRAaWM5>; Wed, 31 Jan 2001 17:12:57 -0500
Received: from ARGENTIUM.MIT.EDU ([18.241.0.107]:36357 "EHLO argentium.mit.edu")
	by vger.kernel.org with ESMTP id <S129091AbRAaWMr>;
	Wed, 31 Jan 2001 17:12:47 -0500
Message-ID: <3A788DDE.AF82E72F@mit.edu>
Date: Wed, 31 Jan 2001 17:12:46 -0500
From: Matt Yourst <yourst@mit.edu>
Organization: Massachusetts Institute of Technology
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-mtyrel-i686pII i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compiling 2.4.1: undefined reference to `__buggy_fxsr_alignment'
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried to compile 2.4.1 and I'm getting the error "undefined
reference to `__buggy_fxsr_alignment'" when trying to do the final
link. It looks like this check was something 2.4.1 added to
include/asm-i386/bugs.h to fail the kernel build if part of the thread
structure wasn't aligned on a 16-byte boundary (which seems to make
sense given FXSR's alignment requirements.) When was this check added?
I assumed it was a bug in 2.4.0 that was just recently discovered, but
I didn't see anything in the ChangeLog to that effect.

The problem is that I don't know how to fix it (at least not reliably
and cleanly.) I tried rearranging the fields in the task structure,
but the alignment still wasn't right. I did apply a few non-standard
patches that expanded the task structure, but the additional fields
came well after the task's struct thread (which was causing the
alignment problem.) FYI, I'm compiling with pgcc 2.95.2 and linking
with binutils/ld 2.10 (I've used both of these successfully for
countless kernel compiles before this.)

Anyone else had this problem?

- Matt Yourst

-------------------------------------------------------------
 Matt T. Yourst        Massachusetts Institute of Technology
 yourst@mit.edu                                 617.225.7690
 513 French House - 476 Memorial Drive - Cambridge, MA 02139
-------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

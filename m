Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKOAmO>; Tue, 14 Nov 2000 19:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQKOAmF>; Tue, 14 Nov 2000 19:42:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129047AbQKOAlu>;
	Tue, 14 Nov 2000 19:41:50 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011150001.AAA00723@raistlin.arm.linux.org.uk>
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 15 Nov 2000 00:01:15 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), torvalds@transmeta.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <20554.974126251@redhat.com> from "David Woodhouse" at Nov 13, 2000 02:37:31 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> If we don't specify CLONE_FS | CLONE_FILES | CLONE_SIGHAND then new ones 
> get allocated just for us to free them again immediately. If we clone them, 
> then we just increase and decrease the use counts of the parent's ones. The 
> latter is slightly more efficient, and I don't think it really matters. If 
> you really care, that can be changed. I've dropped CLONE_SIGHAND because 
> daemonize() doesn't free that, but left CLONE_FS and CLONE_FILES.

Small suggestion - when your thread is created, make sure that all /proc
accesses to stuff relating to this thread doesn't cause the kernel to panic.

I used to create some processes with '0' as the third arg until Debian's
start-stop-daemon script started killing peoples machines with a kernel
oops.  Now I always use CLONE_FS | CLONE_FILES | CLONE_SIGHAND as per
fs/buffer.c (which I used as the reference for creating kernel threads).
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

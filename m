Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S133081AbQK0AJG>; Sun, 26 Nov 2000 19:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S133085AbQK0AI4>; Sun, 26 Nov 2000 19:08:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19490 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S133081AbQK0AIm>; Sun, 26 Nov 2000 19:08:42 -0500
Date: Mon, 27 Nov 2000 00:38:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kernel_thread bogosity
Message-ID: <20001127003844.C23807@athlon.random>
In-Reply-To: <20001123232333.A6426@bug.ucw.cz> <20001124014830.I1461@athlon.random> <20001124205247.A141@bug.ucw.cz> <20001126172658.A5636@athlon.random> <20001126232932.A4052@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001126232932.A4052@bug.ucw.cz>; from pavel@suse.cz on Sun, Nov 26, 2000 at 11:29:32PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 11:29:32PM +0100, Pavel Machek wrote:
> Is this different on x86-64 in long mode?

Yes, in 64bit mode ss:rsp is restore unconditionally. In compatibility and
legacy modes it's restored only if the CPL changes.

kernel never runs in compatibility mode (and userspace never runs iret) so in
kernel_thread we know x86-64 always restores ss:rsp from the stack.

You should find this as a familiar behaviour as you just tried to pass a stack
via kernel_thread in your latest patch against cvs :).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

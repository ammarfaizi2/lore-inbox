Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRATVIr>; Sat, 20 Jan 2001 16:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRATVI2>; Sat, 20 Jan 2001 16:08:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28000 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130230AbRATVIW>; Sat, 20 Jan 2001 16:08:22 -0500
Date: Sat, 20 Jan 2001 22:05:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010120220521.C5274@athlon.random>
In-Reply-To: <20010120203023.A5274@athlon.random> <200101201939.WAA05326@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101201939.WAA05326@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sat, Jan 20, 2001 at 10:39:36PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 10:39:36PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Much saner behaviour wrt latency (and perfect clarity) overweights

IMHO latency can be fixed in a much better way using ioctl(SIOCPUSH) after the
last write() plus we could also add a MSG_NOMORE to set in the last send().
MSG_NOMORE would be not anonymous-capable but it would have zero syscall cost
compared to SIOCPUSH.

This would also address when the stack still delays something by mistake, and
yes it must still delay something sometime (even if not in my example)
otherwise setsockopt(TCP_NODELAY) is a noop. Whatever heuristic you use it
can't get right all the cases because it misses information that it can't
recover by guessing the right thing to do.  Legacy userspace will run still
fine, optimized software will take advantage of the new capability of the
stack.

In short instead of decreasing merging capabilities of the stack IMHO it's
better to give the information from userspace to the stack to let it know when
it must stop to do merging. This way the stack will always do the right thing.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

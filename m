Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRARToq>; Thu, 18 Jan 2001 14:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130847AbRARTog>; Thu, 18 Jan 2001 14:44:36 -0500
Received: from chiara.elte.hu ([157.181.150.200]:29203 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135445AbRARToP>;
	Thu, 18 Jan 2001 14:44:15 -0500
Date: Thu, 18 Jan 2001 20:43:47 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Rick Jones <raj@cup.hp.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118203802.D28276@athlon.random>
Message-ID: <Pine.LNX.4.30.0101182041240.1009-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Jan 2001, Andrea Arcangeli wrote:

> I'm all for TCP_CORK but it has the disavantage of two syscalls for
> doing the flush of the outgoing queue to the network. And one of those
> two syscalls is spurious. [...]

i believe a network-conscious application should use MSG_MORE - that has
no system-call overhead.

> +	case SIOCPUSH:
> +		lock_sock(sk);
> +		__tcp_push_pending_frames(sk, tp, tcp_current_mss(sk), 1);
> +		release_sock(sk);
> +		break;

i believe it should rather be a new setsockopt TCP_CORK value (or a new
setsockopt constant), not an ioctl. Eg. a value of 2 to TCP_CORK could
mean 'force packet boundary now if possible, and dont touch TCP_CORK
state'.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

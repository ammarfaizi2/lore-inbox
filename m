Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbQJaD7d>; Mon, 30 Oct 2000 22:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130108AbQJaD7X>; Mon, 30 Oct 2000 22:59:23 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:35728 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S130090AbQJaD7I>; Mon, 30 Oct 2000 22:59:08 -0500
Message-ID: <39FE39EF.62CC880B@mountain.net>
Date: Mon, 30 Oct 2000 22:18:07 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-t10p5-kdb i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] ipv4 skbuff locking scope
In-Reply-To: <39FDF518.A9F1204D@mountain.net> <200010302224.OAA02266@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Mon, 30 Oct 2000 17:24:24 -0500
>    From: Tom Leete <tleete@mountain.net>
> 
>    This fixes tests of a socket buffer done without holding the
>    lock. tcp_data_wait() and wait_for_tcp_memory() both had
>    unguarded refs in their sleep conditionals.
> 
> These are not buggy at all, see the discussion which took place here
> over the past few days.

I'll post traces privately. It was my lockups that got Rick
interested.
 
> Look, if the sleep condition test "races" due to not holding the lock,
> the schedule() just returns because if the sleep condidion test passes
> then by definition this means we were also woken up, see?

Would you explain what is accomplished by toggling the lock
every time through? What breaks by not doing so?

> BTW, while we're on the topic of people not understanding the
> networking locking and proposing bogus patches, does anyone know who
> sent the bogon IP tunneling locking "fixes" to Linus behind my back?

Not me, but see below.
 
> They were crap too, and I had to revert them in test10-pre7.  It's
> another case of people just not understanding how the code works and
> thus that it is correct without any changes.

If it's perfect why can't I use it without locking up the
machine? BTW, I'm currently running my patch. I can now
flood ping 100000 packets in either direction. With
unmodified tcp that is a red switcher (reliably hard locks
all i/o including the serial console).

> Please send such fixes to me, and I'll set you straight with a
> description as to why your change is unnecessary :-)

Perhaps that's why somebody wants to bypass you.

Tom Leete
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

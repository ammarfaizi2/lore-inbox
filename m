Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSLWDAT>; Sun, 22 Dec 2002 22:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266308AbSLWDAS>; Sun, 22 Dec 2002 22:00:18 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:16518 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S262604AbSLWDAS>;
	Sun, 22 Dec 2002 22:00:18 -0500
Date: Mon, 23 Dec 2002 04:08:12 +0100
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/net/tcp + ipv6 hang
Message-ID: <20021223030812.GA18409@gagarin>
References: <20021223015723.GA17439@gagarin> <20021223024017.GO4942@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021223024017.GO4942@conectiva.com.br>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18QIwu-00051J-00*Iq6gpbTABOM* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 12:40:17AM -0200, Arnaldo Carvalho de Melo wrote:
> 
> Anders, if you're feeling brave, from the top of my head, think about what
> happens if somebody only reads the first, say, 10 bytes of /proc/net/tcp, will
> we unlocking a not held lock at tcp_seq_stop, no? :-)

Yes, I was just looking into the locking... But it's rather messy with locks
between calls and goto's and I think I'd better get some sleep before saying
anything for certain. Is there any reason holding the lock between
listening_get_first() and the first call to listening_get_next(), but not
between consecutive calls to listening_get_next()? Otherwise we could just
always release the lock in listening_get_first.

(All this applies to established_get_first/next too.)

OOPS, I just realizes we might be talking about different locks :)

I was talking about 
read_[un]lock_bh(&tp->syn_wait_lock); in listening_get_first/next

What lock are you talking about?
As far as I can see, in TCP_SEQ_STATE_OPENREQ tp->syn_wait_lock is always
held and in TCP_SEQ_STATE_LISTENING the tcp_listen_lock and so on?

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/

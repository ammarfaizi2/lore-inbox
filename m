Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSGXNDC>; Wed, 24 Jul 2002 09:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSGXNDB>; Wed, 24 Jul 2002 09:03:01 -0400
Received: from mons.uio.no ([129.240.130.14]:48060 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317025AbSGXNDB>;
	Wed, 24 Jul 2002 09:03:01 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, trond.myklebust@fys.uio.no,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.27 fix potential spinlocking race.
References: <Pine.LNX.4.44.0207231922020.6943-100000@home.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 24 Jul 2002 15:05:59 +0200
In-Reply-To: <Pine.LNX.4.44.0207231922020.6943-100000@home.transmeta.com>
Message-ID: <shsbs8xtgw8.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > Trond noticed that kfree_skb() can be called from a _non_ bh
     > context, ie process context. So it needs to protect itself
     > against other bh's on this CPU (which it wouldn't need to do if
     > it was only called from a bh context).

     > So it's exactly your "better context" that is at stake here.

Precisely. Not coming from a computer science background, the jargon
sometimes gets the better of me ;-)

I was playing around with ip_build_xmit_slow() looking at alternatives
for fixing the MSG_DONTWAIT fragmentation bug mentioned on this list a
couple of weeks ago, when I noticed that it can call kfree_skb() from
a process context. This again means that write_space() can get called
without being wrapped in a local_bh_disable()/local_bh_enable() -
style protection against softirqs.

Cheers,
  Trond

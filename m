Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbRFVM7l>; Fri, 22 Jun 2001 08:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265397AbRFVM7b>; Fri, 22 Jun 2001 08:59:31 -0400
Received: from mons.uio.no ([129.240.130.14]:30181 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265396AbRFVM7Q>;
	Fri, 22 Jun 2001 08:59:16 -0400
To: Christian Robottom Reis <kiko@async.com.br>
Cc: <NFS@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>
Subject: Re: [NFS] NFS insanity
In-Reply-To: <Pine.LNX.4.32.0106211942580.322-100000@blackjesus.async.com.br>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Jun 2001 14:58:53 +0200
In-Reply-To: Christian Robottom Reis's message of "Thu, 21 Jun 2001 19:43:28 -0300 (BRT)"
Message-ID: <shsvgloisc2.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Robottom Reis <kiko@async.com.br> writes:

     > anthem:/mondo /mondo nfs
     > defaults,rsize=3072,wsize=3072,suid,async 0 0

     > Async is on, but it's there by default IIRC, right?

Nope. The 'async' option is meaningless to the NFS client. Should make
no difference though, as it's never checked.

I'm a bit surprised about your choice or rsize and wsize. Although it
shouldn't make any difference, 3072 is not a natural size on an x86
machine. You usually want something that divides PAGE_CACHE_SIZE=4096.
Furthermore, on the Linux NFS client, any value < PAGE_CACHE_SIZE
means that you use synchronous writes (deferred writes are enabled
with wsize=4096 or greater).
The advantage in this case though, is that it means any error message
that was returned by the server was guaranteed to have been received
by 'cp', because the page was written to the server immediately.

If I were you therefore, I'd use ethereal or tcpdump to sniff the NFS
traffic and check that the file indeed gets reproduced correctly on
the wire.

Cheers,
  Trond

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263935AbRFHP3k>; Fri, 8 Jun 2001 11:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264017AbRFHP3b>; Fri, 8 Jun 2001 11:29:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23936 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263986AbRFHP3X>;
	Fri, 8 Jun 2001 11:29:23 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15136.61263.7046.76298@pizda.ninka.net>
Date: Fri, 8 Jun 2001 08:29:19 -0700 (PDT)
To: "Eric Barton" <eric@bartonsoftware.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: tcp_recvmsg() in 2.4.4
In-Reply-To: <000e01c0ef7b$8b3a8d20$0281a8c0@ebpc>
In-Reply-To: <000e01c0ef7b$8b3a8d20$0281a8c0@ebpc>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric Barton writes:
 > When it get to if(sk->state == TCP_CLOSE), surely sk->done has already been
 > tested (and the socket is locked), so -ENOTCONN could be returned
 > immediately.

We sleep and drop the lock during these loops, so we need to retest
this each time we wake back up.

 > Actually I'd really appreciate it if someone could explain the order of
 > tests for sk->done, sk->err, sk->shutdown and sk->state...

Most of the error test ordering is specified by POSIX somewhere.

Alan would know better.

Later,
David S. Miller
davem@redhat.com

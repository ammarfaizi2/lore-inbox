Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280622AbRKSTJ1>; Mon, 19 Nov 2001 14:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280625AbRKSTJS>; Mon, 19 Nov 2001 14:09:18 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:51466 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S280622AbRKSTJJ>;
	Mon, 19 Nov 2001 14:09:09 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111191909.WAA21357@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no
Date: Mon, 19 Nov 2001 22:09:00 +0300 (MSK)
Cc: b.lammering@science-computing.de, linux-kernel@vger.kernel.org
In-Reply-To: <15353.21949.239139.993379@charged.uio.no> from "Trond Myklebust" at Nov 19, 1 07:55:57 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Originally I had a test for whether sock_wspace(sk) was greater than
> some minimal value. We need this for UDP in order to avoid waking up
> 'rpciod' before the socket buffer is large enough to accommodate the
> RPC datagram. 

I do no think this was right, to be honest. write_space with udp is
too hairy thing to use it correctly. :-) Anyway, it is enough to select
right sndbuf. Right is... well, default value is right. :-)


>	As the same code worked in 2.2.x for TCP, I had assumed
> it was OK...

Most likely, it worked because 2.2 did not protect of overschedule
and waked up thread each time when some space was freed, so it was enough
that wakeup predicate used by tcp and by application had one common point:
wmem_alloc==0 and they always have it. 2.4 does not wake
up process, if it did not see full buffer after previous wakeup.

Alexey

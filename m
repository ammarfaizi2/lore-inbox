Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132940AbRDKTFg>; Wed, 11 Apr 2001 15:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRDKTFT>; Wed, 11 Apr 2001 15:05:19 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:1043 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132940AbRDKTEN>;
	Wed, 11 Apr 2001 15:04:13 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104111904.XAA10804@ms2.inr.ac.ru>
Subject: Re: Bug report: tcp staled when send-q != 0, timers == 0.
To: berd@elf.ihep.su (Eugene B. Berdnikov)
Date: Wed, 11 Apr 2001 23:04:04 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010411223536.A19364@elf.ihep.su> from "Eugene B. Berdnikov" at Apr 11, 1 10:35:36 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>  In my experiments linux simply sets mss=mtu-40 at the start of ethernet
>  connections. I do not know why, but belive it's ok. How the version of
>  kernel and configuration options can affect mss later?

You can figure out this yourself. In fact you measured this.

With mss=1460 the problem does not exist.

The problem begins f.e. when mss is less and packet arrives on ethernet.
It eats the same 1.5k of memory, but carries only ~mss bytes of tcp payload.
See? We do not know this forward, advertise large window, have not enough
rcvbuf to get it filled and cannot do anything but dropping new packets.

ppp is more difficult. Actually, I do not know exactly how it works now.
At least, ppp in 2.4 trims skb if it has too much of unused space.

Alexey

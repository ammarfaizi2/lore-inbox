Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276935AbRJNTMr>; Sun, 14 Oct 2001 15:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276990AbRJNTMg>; Sun, 14 Oct 2001 15:12:36 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:56839 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276935AbRJNTMR>;
	Sun, 14 Oct 2001 15:12:17 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110141912.XAA06706@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Sun, 14 Oct 2001 23:12:31 +0400 (MSK DST)
Cc: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BC9DE09.747F45B2@welho.com> from "Mika Liljeberg" at Oct 14, 1 09:48:41 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > But sending ACK on buffer drain at least for short
> > packets is real demand, which cannot be relaxed.
> 
> Why? This one has me stumped.

To remove sick delays with nagling transfers (1) and to remove
deadlocks due to starvation on rcvbuf (2) at receiver and on sndbuf
at sender (3).

Actually, (2) is solved nowadays with compressing queue. (3) can be solved
acking each other segment. But (1) remains. The solution used in 2.2,
when delack timeout was reduced to short value on short packets with PSH
set worked with probability of 50% on very slow links i.e. in the case
when wrong delay is not important at all and not covering cases
where absence of long gaps is really important.

Actually, any alternative idea how to solve this could be very useful.

Alexey

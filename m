Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbRBRUSn>; Sun, 18 Feb 2001 15:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129273AbRBRUSc>; Sun, 18 Feb 2001 15:18:32 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:64008 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129272AbRBRUST>;
	Sun, 18 Feb 2001 15:18:19 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102182017.XAA28119@ms2.inr.ac.ru>
Subject: Re: MTU and 2.4.x kernel
To: davem@redhat.com (David S. Miller)
Date: Sun, 18 Feb 2001 23:17:46 +0300 (MSK)
Cc: alan@lxorguk.ukuu.org.uk, roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <14991.38968.898918.345197@pizda.ninka.net> from "David S. Miller" at Feb 18, 1 01:39:04 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This smells bad.  Datagram protocol send sizes are only limited by
> socket buffer size, nothing more.  Fragmentation makes it work.

The thread was started from the observation that fragmented frames
do _not_ pass through router. See? 8)

Path mtu discovery exists exactly to help to solve this problem.

In this case mtu is too low to be accepted by pmtu discovery,
so that we simply disable it and start to fragment, exaclty like
pmtu discovery was disabled completely. With all the consequences.

So that workaround is not to _disable_ path mtu discovery,
but to _enforce_ it, changing thresholds.

The argument is subjectless. min_adv_mss must be changed to 256
in production version, no doubts. min_pmtu must stay at its current value
of 576. That's all.

Alexey

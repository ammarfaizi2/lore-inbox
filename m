Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbRL2UiE>; Sat, 29 Dec 2001 15:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285475AbRL2Uhy>; Sat, 29 Dec 2001 15:37:54 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:56845 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S285449AbRL2Uhl>;
	Sat, 29 Dec 2001 15:37:41 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112292037.XAA12592@ms2.inr.ac.ru>
Subject: Re: AX25/socket kernel PATCHes
To: alan@lxorguk.UKuu.ORG.UK (Alan Cox)
Date: Sat, 29 Dec 2001 23:37:18 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16KNor-00059i-00@the-village.bc.nu> from "Alan Cox" at Dec 29, 1 09:15:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So that it checks
> 			< skb2->data || nh.raw > ..
> 
> Let me know if that fixes it. It shouldn't but it would be good to know if
> we are picking up header only frames somewhere, or nh.raw has accidentally
> been pushed on one header too far.

Indeed... This fix would be right in any case.


I want to remind why this check is made: this pointer must not show
to heavens and it must not be NULL. This property was not held in the past,
hence this bug trap was inserted. It can be relaxed, provided it preserves
its sanitizing function.

Also, note that real value of nh.raw is private to protocol.
Particularly, it can be equal to mac.raw. The best thing to do is
to set it to the same position as it would have if the same packet
appeared on input. But it is not an absolute requirement,
as soon as raw packet socket cannot hold it.

Alexey

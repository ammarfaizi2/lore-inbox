Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267517AbRHAQxR>; Wed, 1 Aug 2001 12:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267514AbRHAQxH>; Wed, 1 Aug 2001 12:53:07 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:58121 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267517AbRHAQwy>;
	Wed, 1 Aug 2001 12:52:54 -0400
Message-Id: <200107312243.CAA00461@mops.inr.ac.ru>
Subject: Re: Linux sk_buff issues.
To: pschulz@foursticks.COM.AU (Paul Schulz)
Date: Wed, 1 Aug 2001 02:43:34 -2000 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15RSJ5-0001mT-00@mars.foursticks.com.au> from "Paul Schulz" at Jul 31, 1 10:15:00 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>							 I am assuming using
> skb->nh.raw is the corrent version to use at this point.

Yes, nh is almost always set to right value, unlike h.

"Almost" is because, it is possible to see it shifted
when packet is sent via raw packet socket with an complicaed MAC header.
Shortly, corresponding pointer is reliable when packet originated
by corresponding part of code. h is reliable, when packet is sourced
by tcp/udp, nh - when it is srourced by a protocol.

The only 100% right way is to parse from skb->data and skip mac header
at el.

Alexey

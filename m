Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131505AbRC3RP3>; Fri, 30 Mar 2001 12:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131555AbRC3RPS>; Fri, 30 Mar 2001 12:15:18 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:41737 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131505AbRC3RPM>;
	Fri, 30 Mar 2001 12:15:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103301713.VAA03794@ms2.inr.ac.ru>
Subject: Re: IP layer bug?
To: green@dredd.crimea.edu (Oleg Drokin)
Date: Fri, 30 Mar 2001 21:13:40 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <20010325005731.A5243@dredd.crimea.edu> from "Oleg Drokin" at Mar 25, 1 00:57:31 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>    For now I workarounded it with filling skb->cb with zeroes before
>    netif_rx(),

This is right. For another examples look into tunnels.

> but I believe it is a kludge and networking layer should be fixed instead.

No.

alloc_skb() creates skb with clean cb. ip_rcv() and other protocol handlers
do not redo this work. If device uses cb internally, it must clear it
before handing skb to netif_rx().

Alexey

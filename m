Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263261AbREMSUl>; Sun, 13 May 2001 14:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263220AbREMSUb>; Sun, 13 May 2001 14:20:31 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:262 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S263062AbREMSUP>;
	Sun, 13 May 2001 14:20:15 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105131819.WAA27939@ms2.inr.ac.ru>
Subject: Re: NETDEV_CHANGE events when __LINK_STATE_NOCARRIER is modified
To: davem@redhat.COM (David S. Miller)
Date: Sun, 13 May 2001 22:19:50 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15091.23655.488243.650394@pizda.ninka.net> from "David S. Miller" at May 5, 1 06:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I believe these events get sent to the cardmgr daemon and it does
> all the ifconf magic to change the device state.

Compare this also to the situation with netif_present().

After Linus said that it is called from thread context, I prepared
corresponding code for netif_present (and for carrier detection
in assumption it is called from thread context or softirq)
BUT... this happened to be not true.

So, these macros still do not assume anything on context.
As result netif_carrier* is unreliable, netif_present is still straight bug.
Should be fixed, of course.

BTW what did happen with Andrew's netdev registration patch?
By some strange reason I believed it is already applied... Grrr.

Alexey

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271786AbRHUS3u>; Tue, 21 Aug 2001 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271787AbRHUS3l>; Tue, 21 Aug 2001 14:29:41 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:41228 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271783AbRHUS3X>;
	Tue, 21 Aug 2001 14:29:23 -0400
Message-Id: <200108202257.CAA00748@mops.inr.ac.ru>
Subject: Re: Problems with corruption sending packets from a module
To: igloo@earth.li (Ian Lynagh)
Date: Tue, 21 Aug 2001 02:57:08 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010820170424.A713@stu163.keble.ox.ac.uk> from "Ian Lynagh" at Aug 20, 1 09:15:01 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> In case someone is reading the archives and has a similar problem, this
> appears to be the cause of the trouble. If I do
> skb->data += sizeof(struct ethhdr);
> then it's fine. 

It is not fine at all... You are not allowed to change skb->data,
skb->len etc.


>	I guess I ought to be using skb_reserve really

You guess right: skb_reserve(), skb_put() and other functions
provided by skbuff.h. But not to touch pointers directly,
they have dependancies, which are known only to skbuff.[hc].

Alexey

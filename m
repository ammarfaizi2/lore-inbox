Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132419AbRCaPeQ>; Sat, 31 Mar 2001 10:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132427AbRCaPeG>; Sat, 31 Mar 2001 10:34:06 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:56847 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132419AbRCaPd7>;
	Sat, 31 Mar 2001 10:33:59 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103311532.TAA20809@ms2.inr.ac.ru>
Subject: Re: IP layer bug?
To: green@dredd.crimea.edu (Oleg Drokin)
Date: Sat, 31 Mar 2001 19:32:48 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, david-b@pacbell.net
In-Reply-To: <20010331190314.A27130@dredd.crimea.edu> from "Oleg Drokin" at Mar 31, 1 07:03:14 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Hm. But comment in linux/skbuff.h says:

The comment is about more difficult case: transmit path,
where cb is used both by top level protocol and lower layers:
f.e. TCP -> IP -> device. cb is dirty from the moment of skb
creation in this case.

Also, note that the second sentence in the comment is obsolete.
Passing not cloned skbs between layers is strongly deprecated
practice (I hope it is not used in any place) and cb of skb entering
to lower layer is property of the layer.

RX path is simpler: cb must be kept clean, that's all.

General rule is minimization redundant clearings of the area.

> Why not document it somewhere, so that others will not fall into the same trap?

Indeed. 8) You got the experience, which you expect to be useful
for people, it is time to prepare some note recording this. 8)

Alexey

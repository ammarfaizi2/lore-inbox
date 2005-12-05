Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVLEFu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVLEFu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 00:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVLEFu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 00:50:29 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:17030 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1750880AbVLEFu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 00:50:28 -0500
Date: Sun, 4 Dec 2005 21:50:12 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Michael Buesch <mbuesch@freenet.de>
Cc: Feyd <feyd@seznam.cz>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Message-ID: <20051205055012.GE8953@jm.kir.nu>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <20051204205208.46e44480@epsilon.site> <200512042058.30801.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512042058.30801.mbuesch@freenet.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 08:58:30PM +0100, Michael Buesch wrote:

> > Why not use the new in-kernel wifi stack? 
> 
> We do. The SoftMAC is an extension to it.
> SoftMAC = Software Medium Access Control. It is about sending
> and receiving management frames.
> Some chips do this in hardware, so it is not part of the ieee80211 stack.
> (the ipw2x00 do it in hardware, for example.)

Wouldn't it be better to try to get that functionality added into the
net/ieee80211 code instead of maintaining separate extension outside the
kernel tree? Many modern cards need the ability for the host CPU to take
care of management frame sending and receiving and from my view point,
this code should be in net/ieee80211. Many (all?) of the functions in
this "SoftMAC" look like something that would be nice to have as an
option in net/ieee80211. In other words, the low-level driver would
indicate what kind of functionality it needs and ieee80211 stack would
behave differently based on the underlying hardware profile.

ipw2x00 happens to be one of the main users of net/ieee80211 at the
moment, but it is by no means the only one and it should not be
defining what kind of functionality ends up being included in
net/ieee80211.

-- 
Jouni Malinen                                            PGP id EFC895FA

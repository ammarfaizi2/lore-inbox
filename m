Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWHWOlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWHWOlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 10:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWHWOlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 10:41:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:62384 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964905AbWHWOlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 10:41:42 -0400
Subject: Re: [PATCH 2.6.18-rc4] aoe [04/13]: zero copy write 1 of 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Ed L. Cashin" <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
In-Reply-To: <20060822212150.GQ6196@coraid.com>
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
	 <f262a8dec6bec42dce9e5723ff332f5d@coraid.com>
	 <1155982692.4051.9.camel@localhost.localdomain>
	 <20060822212150.GQ6196@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Aug 2006 16:03:06 +0100
Message-Id: <1156345386.3007.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-22 am 17:21 -0400, ysgrifennodd Ed L. Cashin:
> These are skbs pre-allocated by the aoe driver that will always have
> enough room to accomodate this much data, and we are really setting
> the packet header length.

The skb structure has other fields and if you fiddle with them by hand
you break those and you end up breaking if the skb internals change.

Eg if you set skb->len you must set skb->tail. Functions like
skb_addd_data, skb_put, skb_trim, etc do the right thing in all cases.

> To use skb_put here seems awkward.  We'd have to do things like shown
> below throughout the driver instead of just setting the length.  Is
> that what you'd like to see?

Yes. It might take a clock or two longer but it sets skb->tail right and
is rather more future proof.


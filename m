Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTDNU6r (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbTDNU62 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:58:28 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.25]:46147 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263807AbTDNU6V (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:58:21 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: BUGed to death
Date: Mon, 14 Apr 2003 23:10:05 +0200
User-Agent: KMail/1.5.1
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay> <200304142240.41999.baldrick@wanadoo.fr> <20030414210211.GB7831@suse.de>
In-Reply-To: <20030414210211.GB7831@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142310.05110.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BUG_ON is already marked unlikely.
> See include/linux/kernel.h
>
> The costs here are doing the actual checks, nothing to do with
> the branch prediction.

Some places don't seem to know about BUG_ON, for example
(from include/linux/skbuff.h):

static inline char *__skb_pull(struct sk_buff *skb, unsigned int len)
{
        skb->len -= len;
        if (skb->len < skb->data_len)
                BUG();
        return skb->data += len;
}

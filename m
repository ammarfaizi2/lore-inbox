Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755011AbWKLHKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbWKLHKY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 02:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbWKLHKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 02:10:24 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:23389 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753182AbWKLHKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 02:10:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=HV2tZRO5qn8heHz+mBABal68Q/ddqzW3WupbwsUjaIZnJsWFAeL/9wAc++DJUO/4KKgEs2pmVOyC+YbcN2gBSfBxkNqCtfdg0zNqUOnzzWxZEmJl6fx+adSrnYm8QpmsF0dI0XJO5BOlGfi0ba+1VL8I7jZfwyp+aBYY/um9M44=  ;
X-YMail-OSG: 5X9Gio8VM1lS7TMjsytTnrJM3R35t4DlgSwf4xRXnwCe8fuiCbk5li1ZZtu9qlgFkEFurANXIcTgeTefWyYMVw5.faBCYiavd3hEXgXF_zsijwAUroxm
From: David Brownell <david-b@pacbell.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [linux-usb-devel] drivers/usb/gadget/ether.c: NULL dereference
Date: Sat, 11 Nov 2006 23:10:17 -0800
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <20061111160643.GA8809@stusta.de> <200611112235.49931.david-b@pacbell.net> <20061112065008.GF25057@stusta.de>
In-Reply-To: <20061112065008.GF25057@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611112310.18903.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> void dev_kfree_skb_any(struct sk_buff *skb)
> {
>         if (in_irq() || irqs_disabled())
>                 dev_kfree_skb_irq(skb);
>         else
>                 dev_kfree_skb(skb);
> }
> 
> 
> And the first thing dev_kfree_skb_irq() does is to dereference skb...

Yet dev_kfree_skb() --> kfree_skb() starts with the standard idiom

	if (unlikely(!skb))
		return

Seems to me that the finger of blame is more appropriately pointed
at either dev_kfree_skb_any() or dev_kfree_skb_irq() ...

- Dave


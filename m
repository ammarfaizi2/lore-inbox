Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWAKIAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWAKIAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWAKIAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:00:17 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52915
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750885AbWAKIAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:00:16 -0500
Date: Wed, 11 Jan 2006 00:00:20 -0800 (PST)
Message-Id: <20060111.000020.25886635.davem@davemloft.net>
To: drepper@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ntohs/ntohl and bitops
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43C42F0C.10008@redhat.com>
References: <43C42F0C.10008@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulrich Drepper <drepper@redhat.com>
Date: Tue, 10 Jan 2006 14:02:52 -0800

> I just saw this in a patch:
> 
> +               if (ntohs(ih->frag_off) & IP_OFFSET)
> +                       return EBT_NOMATCH;
> 
> This isn't optimal, it requires a byte switch little endian machines.
> The compiler isn't smart enough.  It would be better to use
> 
>      if (ih->frag_off & ntohs(IP_OFFSET))
> 
> where the byte-swap can be done at compile time.  This is kind of ugly,
> I guess, so maybe a dedicate macro
> 
>     net_host_bit_p(ih->frag_off, IP_OFFSET)

The first suggestion isn't considered ugly, and the best form is:

	if (ih->frag_off & __constant_htons(IP_OFFSET))

I'll fix that up when I get a chance, thanks for catching it Uli.

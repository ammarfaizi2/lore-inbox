Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUBTWkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUBTWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:40:22 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:27613 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261405AbUBTWkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:40:11 -0500
Subject: Re: [PATCH/proposal] dm-crypt: add digest-based iv generation mode
From: Christophe Saout <christophe@saout.de>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040220185340.GA14358@leto.cs.pocnet.net>
References: <20040219170228.GA10483@leto.cs.pocnet.net>
	 <20040219111835.192d2741.akpm@osdl.org>
	 <20040220171427.GD9266@certainkey.com>
	 <20040220185340.GA14358@leto.cs.pocnet.net>
Content-Type: text/plain
Message-Id: <1077316812.24726.5.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 23:40:13 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

> The crypto_hmac_init part could be done in the dm target constructor
> once and then call crypto_hmac_update and crypto_hmac_final in the
> iv_generator but this would require some cryptoapi hacking which I'm
> not too happy about. I would like to make a copy of the tfm (including
> the private context) on the stack and then operate on that copy for
> crypto_hmac_update and crypto_hmac_final.
> 
> Can I have a function to return the tfm size so I can do a memcpy
> to a variable on the stack? I could get rid of the mutex too then.

What do you think of this?

I would like to copy the tfm onto the stack so that I can
a) compute the hmac on several CPUs at the same time without locking
b) reuse a precomputed tfm from just after crypt_hmac_init



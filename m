Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268105AbUH3O4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268105AbUH3O4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268476AbUH3O4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 10:56:42 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:9893 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S268105AbUH3OzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 10:55:09 -0400
Date: Mon, 30 Aug 2004 09:53:51 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CryptoAPI: schedual while atomic
Message-ID: <20040830135351.GJ11307@certainkey.com>
References: <20040830132453.GG11307@certainkey.com> <Xine.LNX.4.44.0408301040200.21963-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0408301040200.21963-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 10:42:11AM -0400, James Morris wrote:
> Where is the code which caused this?  The transforms are safe to use (but
> not allocate) in process and softirq contexts.

In add_entropy_words of random.c my experimental code is calling
crypto_digest_update().  In update() it calles crypto_yield.
add_entropy_words() is being call ed directly from a keyboard_interrupt.  I
was hoping to tidy up the code a bit by not using batch_entropy_stores... but
I guess that's unavoidable then?

Last question:
 Would spin_lock_irqsave() spin_unlock_irqrestore() still needed to surround
 crypto_digest_update() calls if they're going to be scattered/gathered
 later?

Thanks for your time.

JLC

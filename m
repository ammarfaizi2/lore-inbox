Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268470AbUH3PHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268470AbUH3PHA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUH3PHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:07:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9436 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268452AbUH3PGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:06:42 -0400
Date: Mon, 30 Aug 2004 11:06:36 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CryptoAPI: schedual while atomic
In-Reply-To: <20040830135351.GJ11307@certainkey.com>
Message-ID: <Xine.LNX.4.44.0408301104010.22050-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Jean-Luc Cooke wrote:

> On Mon, Aug 30, 2004 at 10:42:11AM -0400, James Morris wrote:
> > Where is the code which caused this?  The transforms are safe to use (but
> > not allocate) in process and softirq contexts.
> 
> In add_entropy_words of random.c my experimental code is calling
> crypto_digest_update().  In update() it calles crypto_yield.
> add_entropy_words() is being call ed directly from a keyboard_interrupt.  I
> was hoping to tidy up the code a bit by not using batch_entropy_stores... but
> I guess that's unavoidable then?

You can't call crypto routines from hardirq context.   Think about how 
slow crypto is and why you don't want it running in a hardware irq.


> Last question:
>  Would spin_lock_irqsave() spin_unlock_irqrestore() still needed to surround
>  crypto_digest_update() calls if they're going to be scattered/gathered
>  later?

Not sure exactly what you mean, but you need to serialize calls to 
crypto_digest_update(), yes.


- James
-- 
James Morris
<jmorris@redhat.com>



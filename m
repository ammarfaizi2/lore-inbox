Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265030AbUELOmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbUELOmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 10:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbUELOmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 10:42:23 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:17283 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S265030AbUELOmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 10:42:22 -0400
Date: Wed, 12 May 2004 16:42:21 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, James Morris wrote:

> On Tue, 11 May 2004, Michal Ludvig wrote:
>
> > Second patch - now the PadLock-specific part.
>
> Can you please just follow the model of arch/s390/crypto/ ?
>
> This is arch-specific hardware, and should not need any changes to the
> existing crypto API at this stage.

I only briefly looked at the s390 crypto driver and it looks like it uses
a special /dev node along with some read/write/ioctl calls to do the
encryption. I.e. it doesn't seem to integrate with the CryptoAPI at all.
How could that be used for e.g. IPsec, cryptoloop, etc?

My padlock driver can be used for anything that uses CryptoAPI and in fact
it speeds things a lot (see a simple disk-based benchmark at
http://www.logix.cz/michal/dl/padlock.xp).

In fact I believe that the hardware-specific drivers (e.g. the S/390 one)
should be used in the cryptoapi as well and then the kernel should provide
a single, universal device with read/write/ioctl calls for all of them.
Not making a separete device for every piece of hardware on the market.
Am I wrong?

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal

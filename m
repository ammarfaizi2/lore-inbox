Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUEJTX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUEJTX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUEJTX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:23:59 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:61581 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S261300AbUEJTX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:23:57 -0400
Date: Mon, 10 May 2004 21:23:57 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
Message-ID: <Pine.LNX.4.53.0405102109240.18545@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405101152550.1943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, James Morris wrote:

> On Mon, 10 May 2004, Michal Ludvig wrote:
>
> > It adds two new config options in the Cryptography section and if
> > these are selected, aes.ko is built with the support for PadLock ACE.
> > It can always be disabled with 'disable_via_padlock=1' module option
> > in this case, or if the PadLock is not found in the CPU, aes.ko
> > reverts to the software encryption.
>
> We really need a proper framework for this (i.e. per-arch hardware and asm
> support), not just hacks to the software AES module.

Yes, I know the presented approach wasn't too generic.

How about doing it in a device-like model? There would be different
providers for e.g. AES encryption and the kernel would autoload one of
them depending on say modprobe.conf settings. This way we'd have AES
implemented in software in one module and the PadLock AES in another.
By default the software versions would be used, but the user could choose
the one specific for their hardware.
Comments?

And how about the first patch for crypto/cipher.c? It extends the
interface for not only encryption/decryption of one block for given
algorithms, but also provides a way to do the transform of the whole
buffer in a given mode (ECB, CBC, ...). Is this acceptable in this form?
Should I do something similar for hash and compress functions to stay
consistent?

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWC1WBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWC1WBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWC1WBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:01:54 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:53256 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932406AbWC1WBx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:01:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BLgCxN9nG7KgUncz6rK+pgRF69zI1Ov8YTV6Sgx+8uuWEqOkTXZ+ikXKWqCP3s+kF5be56XOb+soCRxr9rswwQP6jrWnTRpEyYUd/jX1zj7/v2jHt5UsXPo1v9wwE7DWgcEWcWWZU5m+nurkYNLsYIOgeMatMZLhcyiHhX82bKs=
Message-ID: <c0a09e5c0603281401uaeea6aci57054aef444a5e1@mail.gmail.com>
Date: Tue, 28 Mar 2006 14:01:47 -0800
From: "Andrew Grover" <andy.grover@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Cc: "Chris Leech" <christopher.leech@intel.com>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <D760971F-3C6A-400B-99EA-E95358B37F82@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060311022759.3950.58788.stgit@gitlost.site>
	 <20060311022919.3950.43835.stgit@gitlost.site>
	 <2FF801BB-F96C-4864-AC44-09B4B92531F7@kernel.crashing.org>
	 <c0a09e5c0603281044i57730c66ye08c45aadd352cf8@mail.gmail.com>
	 <D760971F-3C6A-400B-99EA-E95358B37F82@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/06, Kumar Gala <galak@kernel.crashing.org> wrote:

> >> Also, what do you think about adding an operation type (MEMCPY, XOR,
> >> CRYPTO_AES, etc).  We can than validate if the operation type
> >> expected is supported by the devices that exist.
> >
> > No objections, but this speculative support doesn't need to be in our
> > initial patchset.
>
> I don't consider it speculative.  The patch is for a generic DMA
> engine interface.  That interface should encompass all users.  I have
> a security/crypto DMA engine that I'd like to front with the generic
> DMA interface today.  Also, I believe there is another Intel group
> with an XOR engine that had a similar concept called ADMA posted a
> while ago.

Please submit patches then. We will be doing another rev of the I/OAT
patch very soon, which you will be able to patch against. Or, once the
patch gets in mainline then we can enhance it. Code in the Linux
kernel is never "done", and the burden of implementing additional
functionality falls on those who want it.

> Can you explain what the semantics are.
>
> It's been a little while since I posted so my thoughts on the subject
> are going to take a little while to come back to me :)

Yeah. Basically you register as a DMA client, and say how many DMA
channels you want. Our net_dma patch for example uses multiple
channels to help lock contention. Then when channels are available
(i.e. a DMA device added or another client gives them up) then you get
a callback. If the channel goes away (i.e. DMA device is removed
(theoretically possible but practically never happens) or *you* are
going away and change your request to 0 channels) then you get a
remove callback.

This gets around the problem of DMA clients registering (and therefore
not getting) channels simply because they init before the DMA device
is discovered.

Regards -- Andy

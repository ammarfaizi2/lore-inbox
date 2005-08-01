Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVHAExe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVHAExe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 00:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVHAExe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 00:53:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262069AbVHAExd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 00:53:33 -0400
Date: Sun, 31 Jul 2005 21:53:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: ambx1@neo.rr.com
cc: Dave Airlie <airlied@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <2e55d42e7427.2e74272e55d4@columbus.rr.com>
Message-ID: <Pine.LNX.4.58.0507312150320.14342@g5.osdl.org>
References: <2e55d42e7427.2e74272e55d4@columbus.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005 ambx1@neo.rr.com wrote:
> 
> We either need to change every driver to free irqs or "harden" each
> of them.

No. No "either". 

Drivers need to be safe from the hw going away, whether it be physically 
or because it got shut down. 

>  Freeing irqs obviously seems easier.

No.

Freeing irq's DOES NOT HELP.

Listen to me. You need the hardening of the driver anyway for the hotplug 
case. Freeing irq's doesn't do anything for it, it's just shuffling the 
real problem under the carpet.

So fix the damn problem _right_, and suddenly freeing the irq doesn't make 
any difference at all. It's just unnecessary and incorrect complexity.

			Linus

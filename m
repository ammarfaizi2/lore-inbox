Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUBNB01 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 20:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUBNB01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 20:26:27 -0500
Received: from mail.shareable.org ([81.29.64.88]:65410 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264537AbUBNB0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 20:26:18 -0500
Date: Sat, 14 Feb 2004 01:26:16 +0000
From: Jamie Lokier <jamie@shareable.org>
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: FW: spinlocks dont work
Message-ID: <20040214012616.GF31199@mail.shareable.org>
References: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F74@DDCNYNTD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RANDAZZO@ddc-web.com wrote:
> Note the following example:
> 
> driver 'A' calls spin_lock_irqsave and gets through (but does not call
> ..unlock).
> driver 'B' calls spin_lock_irqsave and gets through???
> 
> How can B get through if A did not unlock yet?

Is that code from B an interrupt handler?
If yes, then A should have called spin_lock_irqsave()

Otherwise, is that code from B a softirq or tasklet or timer handler?
If yes, then A should have called spin_lock_bh()

Otherwise, that code from B cannot run unless you are calling
schedule() from A after taking the lock, which is a bug in your code.

-- Jamie

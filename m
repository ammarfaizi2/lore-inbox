Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUIMR6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUIMR6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268139AbUIMR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:58:37 -0400
Received: from ozlabs.org ([203.10.76.45]:8110 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267709AbUIMR6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:58:34 -0400
Subject: Re: Writable module parameters - should be volatile?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Duncan Sands <baldrick@free.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200409121357.25915.baldrick@free.fr>
References: <200409121357.25915.baldrick@free.fr>
Content-Type: text/plain
Message-Id: <1095098065.25641.38.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 03:54:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 21:57, Duncan Sands wrote:
> I declare a writable module parameter as follows:
> 
> static unsigned int num_rcv_urbs = UDSL_DEFAULT_RCV_URBS;
> 
> module_param (num_rcv_urbs, uint, S_IRUGO | S_IWUSR);
> 
> Shouldn't I declare num_rcv_urbs volatile?  Otherwise compiler
> optimizations could (for example) stick it in a register and miss
> any changes made by someone writing to it...

Sure.  If it really matters, you're going to need something stronger
than that, eg module_param_call().  For debugging, it's not usually a
problem.  For more complex parameters, you usually need locks anyway.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell


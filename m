Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVFVWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVFVWNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbVFVWFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:05:08 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63756 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262441AbVFVV7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 17:59:04 -0400
Date: Wed, 22 Jun 2005 23:58:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
Message-ID: <20050622215854.GJ8907@alpha.home.local>
References: <5009AD9521A8D41198EE00805F85F18F067F6A36@sembo111.teknor.com> <84144f020506221243163d06a2@mail.gmail.com> <20050622203211.GI8907@alpha.home.local> <42B9D120.6030108@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9D120.6030108@billgatliff.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 03:59:12PM -0500, Bill Gatliff wrote:
 
> What Sebastien is after is something like this:
> 
> 	enum tclk_regid {TCLK_BASE=0xa80, TCLK_REG0=TCLK_BASE, 
> 	TCLK_REG1=TCLK_BASE+1...};
> 	enum tclk_regid tclk;
> 
> And then later on, if you ask gdb with the value of tclk is, it can tell 
> you "TCLK_REG1", instead of just 0xa801.  You can also assign values to 
> tclk from within gdb using the enumerations, rather than magic numbers.

Bill, this is a good reason, I agree with you. What I did not want to see
was something like :

  enum { TCLK_BASE=0xa80, TCLK_REG0, TCLK_REG1, ... }

> If you insist on using #defines, then you need to do them like this at 
> the very least:
> 
> 	#define TCLK_REG7 (TCLK_BASE+7)
> 
> ... so as to prevent operator precedence problems later on.  I.e. what 
> happens here:
> 
> 	tclk = TCLK_REG7 / 2;
> 
> Not implying that the above is a realistic example, I'm just pointing out 
> a potential gotcha that is easily avoided...

indeed, nearly all defines need to get lots of parenthesis for the exact
same reason.

Thanks for pointing out the gdb trick.
Willy


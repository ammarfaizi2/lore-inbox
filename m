Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUAOFGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 00:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUAOFGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 00:06:38 -0500
Received: from are.twiddle.net ([64.81.246.98]:7564 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263661AbUAOFGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 00:06:37 -0500
Date: Wed, 14 Jan 2004 21:05:26 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       eike-kernel@sf-tec.de, torvalds@osdl.org
Subject: Re: [2.6 patch] if ... BUG() -> BUG_ON()
Message-ID: <20040115050526.GA1883@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Adrian Bunk <bunk@fs.tum.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, eike-kernel@sf-tec.de,
	torvalds@osdl.org
References: <20040113213230.GY9677@fs.tum.de> <20040115102048.4689664e.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115102048.4689664e.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:20:48AM +1100, Rusty Russell wrote:
> The right fix is to hack gcc to allow functions (in this case, BUG()) to have
> an "unlikely" attribute, and therefore know that this branch is unlikely.

The minimal change to make this work is some new annotation that says
that control does not fall through an asm.  Or give up on the keen-o
diagnostics and use __builtin_trap ().

Either way, branches that lead to dead ends (such as trap or abort or
any other noreturn function) are automatically predicted not taken.


r~

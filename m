Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTFPAgN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTFPAgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:36:13 -0400
Received: from are.twiddle.net ([64.81.246.98]:38550 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S263176AbTFPAgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:36:12 -0400
Date: Sun, 15 Jun 2003 17:49:57 -0700
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       ak@muc.de, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters
Message-ID: <20030616004957.GA15350@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, ak@muc.de,
	Roman Zippel <zippel@linux-m68k.org>
References: <Pine.LNX.4.44.0306150951060.8088-100000@home.transmeta.com> <20030616002453.8A9B72C078@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616002453.8A9B72C078@lists.samba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 10:23:41AM +1000, Rusty Russell wrote:
> Since Andi reports that even that doesn't work for x86-64, I'd say
> apply this patch based on his: it's an arbitrary change anyway.

No, Andi located the *real* problem.  The compiler was over-aligning
these objects, which added padding, which broke the array semantics
you were looking for.  The solution is to add an attribute aligned;
he's sent a patch to Linus already.


r~

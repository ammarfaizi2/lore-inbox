Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUF0PmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUF0PmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUF0PmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 11:42:13 -0400
Received: from the-village.bc.nu ([81.2.110.252]:51643 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263457AbUF0PmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 11:42:11 -0400
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
In-Reply-To: <20040627000541.GA13325@taniwha.stupidest.org>
References: <1088266111.1943.15.camel@mulgrave>
	 <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	 <20040626221802.GA12296@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0406261536590.16079@ppc970.osdl.org>
	 <1088290477.3790.2.camel@localhost.localdomain>
	 <20040627000541.GA13325@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1088347046.26753.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 27 Jun 2004 15:37:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-06-27 at 01:05, Chris Wedgwood wrote:
> I'm all for that, except last I counted there are about 5000 users of
> jiffies.  What do you suggest as a replacement API?

For a lot of them they shouldn't be polling. For those that do in
most cases something like

	struct timeout_timer t;

	timeout_set(t, 5 * HZ)
	timeout_cancel(t)

	if(timeout_expired(t))

Where timeout_timer is effectively an existing timer of add_timer
style and a single variable. The code to build that kind of timer
on top of add_timer is trivial.


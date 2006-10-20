Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992493AbWJTFgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992493AbWJTFgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992494AbWJTFgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:36:40 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:44160 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S2992493AbWJTFgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:36:40 -0400
Date: Thu, 19 Oct 2006 23:36:38 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor fixes to generic do_div
Message-ID: <20061020053638.GS2602@parisc-linux.org>
References: <20061020033359.GR2602@parisc-linux.org> <20061019215954.1be82a57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019215954.1be82a57.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 09:59:54PM -0700, Andrew Morton wrote:
> Can we use typecheck(), from include/linux/kernel.h?

I don't know.

It's copied and pasted from down below, so possibly this was
intentionally not used.  or possibly the author didn't know about
typecheck().

If we do use it, we either have to include linux/kernel.h in
asm-generic/div64.h, which drags in a slew of includes of its own, or be
sure that all users already include kernel.h.  i bet they do.

My allmodconfig build is currently testing out the
remove-sched.h-from-asm-parisc-uaccess.h patch based on viro's x86-64
patch seen earlier today, so I won't be testing the second hypothesis
tonight.  Anyone want to try plugging in typecheck() and seeing if
anything breaks?  NB: you'll want to be sure your arch is using
asm-generic/div64, or add the typecheck() to your arch's
asm-foo/div64.h.

We should probably do that anyway, at least for i386.  And then someone
else would maybe wonder what the xtensa port is up to.

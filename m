Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbUKRGmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbUKRGmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 01:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbUKRGmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 01:42:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25352 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262641AbUKRGmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 01:42:12 -0500
Date: Thu, 18 Nov 2004 07:39:26 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken gcc 3.x update ("3.4.3""fixed")
Message-ID: <20041118063926.GG783@alpha.home.local>
References: <20041117222901.01D43101D0@ws1-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117222901.01D43101D0@ws1-3.us4.outblaze.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 05:29:01PM -0500, Clayton Weaver wrote:

> In gcc-3.3.2, string literals like this merely
> got a "deprecated" warning:
> 
> const char * msg = "hello
> world";
> 
> gcc-3.4.3 refuses to parse that at all, reporting

Fortunately, I don't anybody who writes such a crap. The
example you gave here misses a space after 'hello' and
the only way to see it is to put the cursor at the end
of the line. That's why doing this is wrong. It's a
good thing that recent gcc explicitly forbids such
usages, it will force people to fix their code. The
correct way of doing it should be :

const char * msg = "hello "
                   "world";

> gcc-3.4.3 also bloats the kernel a little.
> While stripped application binaries
> (-march=i686 -O2 -fno-strict-aliasing)
> consistently end up smaller than they were
> when compiled with gcc-2.95.3, a 2.4.28-rc3
> kernel ended up 60k bigger with the same
> .config.

Could you please retest with -Os. I've noticed
that starting from about gcc-3.2, code optimized
for speed tended to increase in size (eventhough
sometimes becoming slower). However, code optimized
for size (-Os) clearly reduced its size at the
expense of speed which sometimes fell dramatically.

Regards,
Willy


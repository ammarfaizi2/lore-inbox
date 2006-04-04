Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWDDPd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWDDPd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 11:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWDDPd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 11:33:57 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52417 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750713AbWDDPd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 11:33:56 -0400
Date: Tue, 4 Apr 2006 17:33:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Richard Purdie <richard@openedhand.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH RFC/testing] Upgrade the zlib_inflate library code to a recent version
Message-ID: <20060404153354.GD25130@wohnheim.fh-wedel.de>
References: <1144163888.6441.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1144163888.6441.48.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 April 2006 16:18:08 +0100, Richard Purdie wrote:
> 
> Upgrade the zlib_inflate implementation in the kernel from a patched
> version 1.1.3 to a patched 1.2.3. 

s/1.1.3/1.1.4/

I once pulled all the bugfixes between the versions into the kernel.

> The code in the kernel is about seven years old and I noticed that the
> external zlib library's inflate performance was significantly faster
> (~50%) than the code in the kernel on ARM (and faster again on x86_32).
> 
> For comparison the newer deflate code is 20% slower on ARM and 50%
> slower on x86_32 but gives an approx 1% compression ratio improvement. I
> don't consider this to be an improvement for kernel use so have no plans
> to change the zlib_deflate code.
> 
> Various changes have been made to the zlib code in the kernel, the most
> significant being the extra functions/flush option used by ppp_deflate.
> This update reimplements the features PPP needs to ensure it continues
> to work.
> 
> This code has been tested on ARM under both JFFS2 (with zlib compression
> enabled) and ppp_deflate and on x86_32. JFFS2 sees an approx. 10% real
> world file read speed improvement.
> 
> This patch also removes ZLIB_VERSION as it no longer has a correct
> value. We don't need version checks anyway as the kernel's module
> handling will take care of that for us. This removal is also more in
> keeping with the zlib author's wishes
> (http://www.zlib.net/zlib_faq.html#faq24) and I've added something to
> the zlib.h header to note its a modified version.

Sounds good.

> +#if 0
> +int zlib_inflatePrime(z_streamp strm, int bits, int value)

Was this code dead in 1.2.3 as well?

> +#ifndef PKZIP_BUG_WORKAROUND

For the kernel, we can remove compat code against DOS compilers, etc.
In this particular case, I believe we can just consider data
compressed with PKZIP to be illegal and throw an error.

Overall the patch doesn't contain any obvious problems and seems to do
what you described.  If testing agrees as well, I'm all for merging
it.

Jörn

-- 
It is better to die of hunger having lived without grief and fear,
than to live with a troubled spirit amid abundance.
-- Epictetus

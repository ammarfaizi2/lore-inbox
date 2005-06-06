Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFFELn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFFELn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 00:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFFELn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 00:11:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62219 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261173AbVFFELj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 00:11:39 -0400
Date: Mon, 6 Jun 2005 06:11:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606041101.GA14799@alpha.home.local>
References: <20050605223528.GA13726@alpha.home.local> <20050606010246.GA22252@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606010246.GA22252@animx.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2005 at 09:02:46PM -0400, Wakko Warner wrote:
> Willy Tarreau wrote:
> > Here's a simple trick for all those who try to squeeze their kernels to the
> > absolute smallest size.
> > 
> > I recently discovered p7zip which comes with the LZMA compression algorithm,
> > which is somewhat better than gzip and bzip2 on most datasets, and I also
> > noticed that this tool provides support for gzip and bzip2 outputs. So I tried
> > to produce some of those standard outputs, and observed a slight gain compared
> > to the default tools. The reason is that we can change the number of passes and
> > the dictionnary size.
> 
> Is it any smaller than a UPX'd kernel?  (I think you need the beta version. 
> I know the upx-ucl in debian won't compress but upx-ucl-beta will if you
> force).  I got a significant reduction using it.

It's not better at all, but unfortunately, UPX cannot compress a kernel which
embeds a big initramfs. The problem is that the compressed initramfs is
embedded into vmlinux, which is then compressed into bzImage, and UPX only
replaces the bzImage compression.

May be it would work if we did not compress the initramfs before including
it into the vmlinux.

Willy


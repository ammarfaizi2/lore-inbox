Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264764AbSKDFE0>; Mon, 4 Nov 2002 00:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264895AbSKDFE0>; Mon, 4 Nov 2002 00:04:26 -0500
Received: from are.twiddle.net ([64.81.246.98]:60296 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264764AbSKDFE0>;
	Mon, 4 Nov 2002 00:04:26 -0500
Date: Sun, 3 Nov 2002 21:10:51 -0800
From: Richard Henderson <rth@twiddle.net>
To: Matthew Wilcox <willy@debian.org>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021103211051.A18863@twiddle.net>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Sun, Oct 20, 2002 at 05:31:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 05:31:47AM +0100, Matthew Wilcox wrote:
> -asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf,
> -			     size_t count, loff_t pos)
> +#ifdef __BIG_ENDIAN
> +asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
> +				unsigned int high, unsigned int low)
> +#else
> +asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
> +				unsigned int low, unsigned int high)
> +#endif

Broken for actual 64-bit targets.

I'd suggest frobbing the arguments in arch specific code
for those 32-bit targets that do pad 64-bit arguments to
the next even/odd register.  I disbelieve you can do 
anything cleanly here.


r~

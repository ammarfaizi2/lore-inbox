Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSEUMZW>; Tue, 21 May 2002 08:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSEUMZV>; Tue, 21 May 2002 08:25:21 -0400
Received: from imladris.infradead.org ([194.205.184.45]:55308 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313571AbSEUMZT>; Tue, 21 May 2002 08:25:19 -0400
Date: Tue, 21 May 2002 13:24:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] possible fix for broken floppy driver since 2.5.13
Message-ID: <20020521132451.A13419@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, viro@math.psu.edu,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205201701.TAA04143@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 07:01:52PM +0200, Mikael Pettersson wrote:
> Since 2.5.13 I've been unable to use drivers/block/floppy.c.
> There were two symptoms: /dev/fd0 was read-only until after
> the first read, and writes wrote currupt data to the media.
> 
> The patch below against 2.5.16 fixes these problems for me:
> 
> - The read-only problem was caused by a getblk() call in
>   floppy_revalidate() which had been commented out (2.5.13
>   did away with getblk() altogether.) This call is necessary,
>   so the patch reintroduces a private getblk() in floppy.c.

Please don't use getblk(), but go directly through the bio interface.
In 2.5 the buffer_heads are just a legacy interface for filesystems and
are not supposed to be used by lowlevel drivers.


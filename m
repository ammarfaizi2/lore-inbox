Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSA1X45>; Mon, 28 Jan 2002 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287781AbSA1X4r>; Mon, 28 Jan 2002 18:56:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16466 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287710AbSA1X4b>; Mon, 28 Jan 2002 18:56:31 -0500
Date: Tue, 29 Jan 2002 00:57:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Message-ID: <20020129005736.I1309@athlon.random>
In-Reply-To: <3C55C2AB.AE73A75D@zip.com.au> <20020128221529.24108@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020128221529.24108@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Mon, Jan 28, 2002 at 11:15:28PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 11:15:28PM +0100, Benjamin Herrenschmidt wrote:
> >Well, get_user_pages is used by several parts of the kernel.
> >In the O_DIRECT/map_user_kiobuf case, we could end up asking
> >the disk controller to perform busmastering against the video
> >PCI device, which will probably explode somewhere down the chain.
> 
> Well... not sure. I'd like this to be doable. I have worked
> on some high-end broadcast video stuffs in the past, and we
> did intensive use of direct bus master from the disk controller
> to the framebuffer linear aperture. Actually, we even controlled

you can do direct DMA to framebuffer on most sane hardware, yes.  But
the kiobuf structure on 2.4 doesn't allow that, it only works with valid
'page structures' not physical addresses. This is valid for both rawio
and O_DIRECT. The MM part is the same for both of course.

Andrea

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288498AbSANSJw>; Mon, 14 Jan 2002 13:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288246AbSANSJp>; Mon, 14 Jan 2002 13:09:45 -0500
Received: from ns.caldera.de ([212.34.180.1]:41103 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S288498AbSANSJe>;
	Mon, 14 Jan 2002 13:09:34 -0500
Date: Mon, 14 Jan 2002 19:08:34 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-lvm@sistina.com
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
Message-ID: <20020114190834.A3473@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, linux-lvm@sistina.com,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201141227260.224-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201140957040.15128-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 14, 2002 at 10:01:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 10:01:25AM -0800, Linus Torvalds wrote:
> 
> On Mon, 14 Jan 2002, Alexander Viro wrote:
> >
> > 	Linus, at least some ioctls (e.g. lvm ones) pass kdev_t from/to
> > userland.  While the common policy with ioctls is "anything goes", this
> > kind of abuse is IMNSHO over the top.
> 
> That's completely bogus.
> 
> The good news is that the bit-for-bit representation of old kdev_t and
> "dev_t" are obviously 100% the same, so we should just make the damn thing
> be dev_t, and user land will never notice anything.

Glibc disagrees with you (bits/types.h):

typedef __u_quad_t __dev_t;             /* Type of device numbers.  */

We'd have to use __kernel_dev_t instead which again pulls kernel
headers in..

	Christoph


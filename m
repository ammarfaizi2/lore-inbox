Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279432AbRJWNmp>; Tue, 23 Oct 2001 09:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279437AbRJWNmf>; Tue, 23 Oct 2001 09:42:35 -0400
Received: from ns.caldera.de ([212.34.180.1]:1711 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S279432AbRJWNm1>;
	Tue, 23 Oct 2001 09:42:27 -0400
Date: Tue, 23 Oct 2001 15:42:18 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cdrom-related rmmod races
Message-ID: <20011023154218.A14829@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Alexander Viro <viro@math.psu.edu>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110231057.f9NAvGI31569@ns.caldera.de> <Pine.GSO.4.21.0110230713140.7440-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0110230713140.7440-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Oct 23, 2001 at 07:14:27AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 07:14:27AM -0400, Alexander Viro wrote:
> 
> 
> On Tue, 23 Oct 2001, Christoph Hellwig wrote:
> 
> > Wouldn't it be easier to add a 'struct module *owner' to struct
> > block_device_operations?
> 
> All of them share (in the current tree) block_device_operations -
> cdrom_fops from drivers/cdrom/cdrom.c.  What will you put as
> ->owner there?

Of course they would have to have their own block_device_operations as
well - but they could continue to use the common open method.

Also this would allow to get rid of the MOD_{INC,DEC}_USE_COUNT in the
blockdrivers and thus make it easier for driver writers to create races.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

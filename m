Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUHSJpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUHSJpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264685AbUHSJpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:45:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:14087 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264668AbUHSJpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:45:41 -0400
Date: Thu, 19 Aug 2004 10:45:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040819104534.B7641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <20040816224749.A15510@infradead.org> <m3r7q4huei.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3r7q4huei.fsf@telia.com>; from petero2@telia.com on Thu, Aug 19, 2004 at 01:57:09AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:57:09AM +0200, Peter Osterlund wrote:
> That can actually be avoided by letting the packet driver itself keep
> track of how many unfinished bios there are in the CD request queue.
> This is straightforward to implement.  The only small complication is
> that incoming read requests need to be cloned so that the packet
> driver can use a private bi_end_io function.

Neat, this looks pretty good.  Other comments on the pkt driver (not related
to this patch):

in the blockdev ->open/->release->ioctl you can get your private data
from inode->i_bdev->bd_disk->private_data instead of doing the lookup.

You still have a little to much dev_t handling in your driver for my
taste, I'm going to take a look soon.


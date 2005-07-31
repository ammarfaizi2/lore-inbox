Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVGaOCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVGaOCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 10:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbVGaOCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 10:02:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23988 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261792AbVGaOB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 10:01:58 -0400
Date: Sun, 31 Jul 2005 15:01:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Thomas Heinz <thomasheinz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI DVD-RAM partitions
Message-ID: <20050731140157.GA6173@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Thomas Heinz <thomasheinz@gmx.net>, linux-kernel@vger.kernel.org
References: <42CFC3EF.2090804@gmx.net> <20050712023757.GG26128@infradead.org> <42D37DF5.6060902@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D37DF5.6060902@gmx.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 10:23:17AM +0200, Thomas Heinz wrote:
> Hi Christoph
> 
> You wrote:
> >While adding support for partitions on sr is trivial it has a huge
> >drawback: it's chaning the dev_t space by using up device numbers
> >for partitions, so /dev/sr0 ff will have different device numbers
> >with that change applied.  I have an old patch that's supposed to
> >enable support for partitioned scsi removable devices at
> >http://rechner.lst.de/~hch/hacks/sr-parts.diff, I'm not sure it
> >actually ever worked (but you should get the basic idea from it)
> 
> Ok, thanks for your valuable input. In fact, I thought about making
> the device available both as /dev/srX and /dev/sdX at the same time
> in order to support partitions. In my case it would even suffice to
> make it available as /dev/sdX instead of /dev/srX.

That doesn't make sense because sd is a very different driver from sd.
Besides that aliasing different dev_ts to the same underlying blockdevice
can't work, it's cause all sorts of aliasing problems.

> Since I have no expert knowledge about this topic, I would be
> interested in the general attitude towards "partitions on SCSI
> DVD-RAM media / SCSI removable devices":
> - Are partitions intentionally not supported? If so, why?

Historical coincidence.

> - Does it usually work but not with my specific DVD-RAM model?
>   If so, why?
> - Do you think that this should be fixed?

There's no nice way to fix it unfortunately.

> Please note that personally, I can live with the "losetup hack"
> since it is easy enough to write a program which encapsulates
> partition mounting. However, there might be people which would
> prefer plugging in a (possibly pre-)partitioned medium and
> having the partitions work out of the box in the expected way.

It would probably be better to use device-mapper than the loop device.
I think there's already userland partition parsing code for dm, and
having a simple command line tool to do that, and maybe even automatically
run through udev and creating /dev/sr<num>p<partition> devices would
be very nice to have as an almost invisible workaround.


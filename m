Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbULFBvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbULFBvD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 20:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbULFBvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 20:51:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60599 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261451AbULFBu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 20:50:57 -0500
Date: Mon, 6 Dec 2004 02:50:53 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Martin Pool <mbp@sourcefrog.net>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: rescan partitions returns EIO since 2.6.8
Message-ID: <20041206015052.GC4734@apps.cwi.nl>
References: <200412051403.iB5E3EJ01749@apps.cwi.nl> <20041206004722.GD26060@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206004722.GD26060@hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 11:47:22AM +1100, Martin Pool wrote:
> On  5 Dec 2004, Andries.Brouwer@cwi.nl wrote:
> > Martin Pool changed the behaviour of the BLKRRPART ioctl in 2.6.8.
> > The effect is that one now gets an I/O error when first
> > partitioning an empty disk:
> 
> > # sfdisk /dev/sda
> > Checking that no-one is using this disk right now ...
> > BLKRRPART: Input/output error
> 
> To me it seems more correct that a request to read the partition table
> should fail if the partition table can't be read.

I do not view BLKRRPART as a request to read the partition table.
It is a request to revalidate: "if the disk is in use, return EBUSY,
otherwise, discard any old information, read any new information".
If the disk is blank then there is no new information to read,
that is not an error, and certainly not an I/O error.

> if you really want to roll it back I won't object.

Yes, I think I want to - am getting worried mail from people
who very much dislike I/O errors on a brand-new disk.

Andries

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUJNNs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUJNNs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUJNNs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:48:56 -0400
Received: from mailout.zma.compaq.com ([161.114.64.105]:4111 "EHLO
	zmamail05.zma.compaq.com") by vger.kernel.org with ESMTP
	id S264984AbUJNNsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:48:52 -0400
Date: Thu, 14 Oct 2004 08:48:29 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
Message-ID: <20041014134829.GA21960@beardog.cca.cpqcorp.net>
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net> <20041014083900.GB7747@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014083900.GB7747@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 09:39:00AM +0100, Christoph Hellwig wrote:
> On Wed, Oct 13, 2004 at 04:22:53PM -0500, mike.miller@hp.com wrote:
> > This patch addresses a problem with clustering software and also some of our utilies. We had to modify the modify the open specifically for clustering. This is the same as was done for 2.4. We also have to register the reserved volumes with the OS so when the backup server breaks the reservations he can call BLKRRPART to set the volume to the correct size.
> > We also have to register a controller that may not have any logical volumes configured. This is for the online utils as well as clustering.
> > 
> > Patch applies to 2.6.9-rc4. Please apply in order.
> > Please consider this for inclusion.
> 
> No, this is bogus.  Never call add_disk on a volume that hasn't been
> configured and full set up.  If you need to talk to our driver without
> online volumes add a character device.
> 
This is the way we've done it since the 2.2 kernel. We have legacy applications
in the field that expect to open c?d0 as the controller. Creating a character
device would require all these apps to change.

mikem

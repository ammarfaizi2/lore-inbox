Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270005AbUJNIjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270005AbUJNIjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 04:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269999AbUJNIjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 04:39:33 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:41477 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270002AbUJNIjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 04:39:05 -0400
Date: Thu, 14 Oct 2004 09:39:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mikem@beardog.cca.cpqcorp.net
Cc: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
Message-ID: <20041014083900.GB7747@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	mikem@beardog.cca.cpqcorp.net, akpm@osdl.org, axboe@suse.de,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041013212253.GB9866@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 04:22:53PM -0500, mike.miller@hp.com wrote:
> This patch addresses a problem with clustering software and also some of our utilies. We had to modify the modify the open specifically for clustering. This is the same as was done for 2.4. We also have to register the reserved volumes with the OS so when the backup server breaks the reservations he can call BLKRRPART to set the volume to the correct size.
> We also have to register a controller that may not have any logical volumes configured. This is for the online utils as well as clustering.
> 
> Patch applies to 2.6.9-rc4. Please apply in order.
> Please consider this for inclusion.

No, this is bogus.  Never call add_disk on a volume that hasn't been
configured and full set up.  If you need to talk to our driver without
online volumes add a character device.


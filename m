Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWIHVAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWIHVAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWIHVAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:00:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:28823 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751246AbWIHVAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:00:50 -0400
Date: Fri, 8 Sep 2006 14:00:42 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Maier <balagi@justmail.de>
Cc: linux-kernel@vger.kernel.org, "petero2@telia.com" <petero2@telia.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Message-ID: <20060908210042.GA6877@kroah.com>
References: <op.tfkmp60biudtyh@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tfkmp60biudtyh@master>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 07:55:08PM +0200, Thomas Maier wrote:
> +/sys/block/pktcdvd/<pktdevname>/packet/
> +    statistic         (r)  Show device statistic. One line with
> +                           5 values in following order:
> +                              packets-started
> +                              packets-end
> +                              written in kB
> +                              read gather in kB
> +                              read in kB

Please no.  One value per file is the sysfs rule.

> +    reset_statistic   (w)  Write any value to it to reset
> +                           pktcdvd device statistic values, like
> +                           bytes read/written.
> +
> +    info              (r)  Lots of user readable driver statistics
> +                           and infos. Multiple lines!

Again, no.  Put it in debugfs if you want multiple lines.

> +    write_queue_size  (r)  Contains the size of the bio write
> +                           queue.
> +
> +    write_congestion_off (rw) If bio write queue size is below
> +                              this mark, accept new bio requests
> +                              from the block layer.
> +
> +    write_congestion_on  (rw) If bio write queue size is higher
> +                              as this mark, do no longer accept
> +                              bio write requests from the block
> +                              layer and wait till the pktcdvd
> +                              device has processed enough bio's
> +                              so that bio write queue size is
> +                              below congestion off mark.
> +
> +    mapped_to              Symbolic link to mapped block device
> +                           in the /sys/block tree.

Shouldn't this whole thing be in /sys/class/ instead of /sys/block/ ?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTENUpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTENUpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:45:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:23246 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261265AbTENUpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:45:21 -0400
Date: Wed, 14 May 2003 13:59:49 -0700
From: Greg KH <greg@kroah.com>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev
Message-ID: <20030514205949.GA3945@kroah.com>
References: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305142020.h4EKK9J01052@relax.cmf.nrl.navy.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 04:20:09PM -0400, chas williams wrote:
> this patch adds a reference count to atm_dev, and a lock to
> protect the members of struct atm_dev.  atm_dev_lock is now
> used to protect the atm_dev linked list.  atm_find_dev was
> renamed to atm_dev_lookup.  atm_dev_hold and atm_dev_release
> were added to manipulate atm_dev's reference count.  this
> fixes atm_ioctl()'s troublesome 'global' spinlock.  also,
> got rid of the nodev list of 'unlinked' vccs.
> 
> 
> --- linux-2.5.68/include/linux/atmdev.h.004	Fri May  9 08:30:20 2003
> +++ linux-2.5.68/include/linux/atmdev.h	Wed May 14 12:40:39 2003
> @@ -331,6 +331,8 @@
>  	struct k_atm_dev_stats stats;	/* statistics */
>  	char		signal;		/* signal status (ATM_PHY_SIG_*) */
>  	int		link_rate;	/* link rate (default: OC3) */
> +	atomic_t	refcnt;		/* reference count */

Any reason to not just use a struct device here?  This is a device,
right?  Or at the very least, a kobject would be acceptable.

Please don't roll your own reference counting code, when we've already
gotten a in-kernel version that has been debugged quite well.

Is this going to help us be able to get rid of the MOD_* calls in ATM
drivers soon?

thanks,

greg k-h

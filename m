Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVFIQ5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVFIQ5i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 12:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVFIQ5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 12:57:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:40122 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262208AbVFIQ5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 12:57:34 -0400
Date: Thu, 9 Jun 2005 09:57:19 -0700
From: Greg KH <greg@kroah.com>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, Linas Vepstas <linas@austin.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 03/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050609165719.GC9597@kroah.com>
References: <42A8386F.2060100@jp.fujitsu.com> <42A83B6D.8010703@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A83B6D.8010703@jp.fujitsu.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 09:51:57PM +0900, Hidetoshi Seto wrote:
> +	if( cookie->error || have_error(cookie->dev) )

This should be written as:
	if (cookie->error || have_error(cookie->dev))
instead (note the placement of spaces).

>  /* definition of ia64 iocookie */
> -typedef unsigned long iocookie;
> +struct __iocookie {
> +	struct list_head	list;
> +	struct pci_dev		*dev;	/* targeting device */
> +	unsigned long		error;	/* error flag */
> +};
> +typedef struct __iocookie iocookie;

Hm, why not just make the thing be a "struct iocookie" in the first
place, then we don't have to mess with a typedef at all.  And then each
arch can define how the structure will look like in their private .c
files, ensuring that no user can ever try to touch the structure
themselves.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbWD0L6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbWD0L6D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWD0L6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:58:03 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:2273 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965029AbWD0L6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:58:02 -0400
Date: Thu, 27 Apr 2006 13:57:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 03/16] ehca: structure definitions
Message-ID: <20060427115749.GD32127@wohnheim.fh-wedel.de>
References: <4450A16D.7000008@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A16D.7000008@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 12:48:13 +0200, Heiko J Schick wrote:
> +
> +#ifdef CONFIG_PPC64
> +#include "ehca_classes_pSeries.h"
> +#endif

Is the #ifdef necessary?  Such conditions around header includes often
indicate problems with the included header.  If that is the case here,
you should fix the header in question in a seperate patch.

> +struct ehca_shca {
> +	struct ib_device ib_device;
> +	struct ibmebus_dev *ibmebus_dev;
> +	u8 num_ports;
        ^^
> +	int hw_level;

This will cause some wasted space due to alignment.  There don't seem
to be other u8 or chars to consolidate with here, though.  Still, you
could take another look that your structures have fields on natural
alignment borders and don't grow without you noticing.

> +struct ehca_mr {
> +	union {
> +		struct ib_mr ib_mr;	/* must always be first in ehca_mr */
> +		struct ib_fmr ib_fmr;	/* must always be first in ehca_mr */
> +	} ib;
> +
> +	spinlock_t mrlock;
> +
> +	/* !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> +	 * !!! ehca_mr_deletenew() memsets from flags to end of structure
> +	 * !!! DON'T move flags or insert another field before.
> +	 * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
> */

Yuck!  Do you have really good reasons to play such games?

> +struct ehca_pfpd {
> +};
> +
> +struct ehca_pfmr {
> +};
> +
> +struct ehca_pfmw {
> +};

Why these?

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu

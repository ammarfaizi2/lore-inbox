Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbTJFOBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTJFOBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:01:32 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:38672 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262111AbTJFOBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:01:31 -0400
Date: Mon, 6 Oct 2003 15:01:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
Message-ID: <20031006150123.A17816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031006092448.GC1786@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031006092448.GC1786@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Mon, Oct 06, 2003 at 11:24:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 11:24:48AM +0200, Martin Schwidefsky wrote:
> +static void
> +chp_release(struct device *dev)
> +{
> +}
> +
>  /*
>   * Entries for chpids on the system bus.
>   * This replaces /proc/chpids.
> @@ -863,8 +869,10 @@
>  	/* fill in status, etc. */
>  	chp->id = chpid;
>  	chp->state = status;
> -	chp->dev.parent = &css_bus_device;
> -
> +	chp->dev = (struct device) {
> +		.parent  = &css_bus_device,
> +		.release = chp_release,
> +	};

Eek.  How is the dummy release function supposed to help
anything?  you must free the object in ->release.  Also
the assignment is horrible as hell.

Dito for the following patches.


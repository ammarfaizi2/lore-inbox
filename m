Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWGQVL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWGQVL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWGQVL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:11:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:53461 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751195AbWGQVL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:11:57 -0400
Date: Mon, 17 Jul 2006 14:04:25 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: stable@kernel.org, Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       akpm@osdl.org, "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, alan@lxorguk.ukuu.org.uk
Subject: Re: [Fwd: Re: [PATCH] tpm: interrupt clear fix]
Message-ID: <20060717210425.GA16076@kroah.com>
References: <1153161320.4808.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153161320.4808.11.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2006 at 11:35:20AM -0700, Kylene Jo Hall wrote:
> -------- Forwarded Message --------
> From: Kylene Jo Hall <kjhall@us.ibm.com>
> To: linux-os (Dick Johnson) <linux-os@analogic.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>, TPM Device Driver List
> <tpmdd-devel@lists.sourceforge.net>, akpm@osdl.org
> Subject: Re: [PATCH] tpm: interrupt clear fix
> Date: Thu, 13 Jul 2006 12:24:36 -0700
> Under stress testing I found that the interrupt is not always cleared.
> This is a bug and this patch should go into 2.6.18 and 2.6.17.x.
> 
> On Thu, 2006-07-13 at 07:45 -0400, linux-os (Dick Johnson) wrote:
> 
> > PCI devices need a final read to flush all pending writes. Whatever
> > mb() does, just hides the problem.
> 
> 
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
> 
> --- linux-2.6.18-rc1/drivers/char/tpm/tpm_tis.c	2006-07-13 14:46:39.727500500 -0500
> +++ linux-2.6.18-rc1-tpm/drivers/char/tpm/tpm_tis.c	2006-07-13 14:47:33.878884750 -0500
> @@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
>  	iowrite32(interrupt,
>  		  chip->vendor.iobase +
>  		  TPM_INT_STATUS(chip->vendor.locality));
> +	ioread32(chip->vendor.iobase + TPM_INT_STATUS(chip->vendor.locality));
>  	return IRQ_HANDLED;
>  }

So does this replace the other tpm patch?  Or should we apply both of
them?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWGQQz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWGQQz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWGQQz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:55:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:54914 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751041AbWGQQz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:55:58 -0400
Subject: Re: [patch 27/45] tpm: interrupt clear fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060717162806.GB4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
	 <20060717162806.GB4829@kroah.com>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 09:56:03 -0700
Message-Id: <1153155363.4808.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a different patch proposed and accepted already for this fix
based on comments on the list.

Thanks,
Kylie


On Mon, 2006-07-17 at 09:28 -0700, Greg KH wrote:
> plain text document attachment (tpm-interrupt-clear-fix.patch)
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Kylene Jo Hall <kjhall@us.ibm.com>
> 
> Under stress testing I found that the interrupt is not always cleared.
> This is a bug and this patch should go into 2.6.18 and 2.6.17.x.
> 
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
>  drivers/char/tpm/tpm_tis.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-2.6.17.6.orig/drivers/char/tpm/tpm_tis.c
> +++ linux-2.6.17.6/drivers/char/tpm/tpm_tis.c
> @@ -424,6 +424,7 @@ static irqreturn_t tis_int_handler(int i
>  	iowrite32(interrupt,
>  		  chip->vendor.iobase +
>  		  TPM_INT_STATUS(chip->vendor.locality));
> +	mb();
>  	return IRQ_HANDLED;
>  }
>  
> 
> --


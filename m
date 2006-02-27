Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWB0WCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWB0WCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWB0WCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:02:24 -0500
Received: from ms-smtp-01-lbl.southeast.rr.com ([24.25.9.100]:7926 "EHLO
	ms-smtp-01-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932347AbWB0WCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:02:23 -0500
Subject: Re: [patch 16/17] s390: multiple subchannel sets support.
From: Greg Smith <gsmith@nc.rr.com>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
In-Reply-To: <20060227091546.2d63209b@gondolin.boeblingen.de.ibm.com>
References: <1140865922.3513.87.camel@localhost.localdomain>
	 <20060227091546.2d63209b@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 17:02:15 -0500
Message-Id: <1141077735.3509.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 09:15 +0100, Cornelia Huck wrote:

> The architecture seems to disagree somewhat :)

You mean you all got doc??  What kind of hackers R u guys ;-)

> anyway... I'd prefer the following patch:

Works for me (tm)

> s390: Improve response code handling in chsc_enable_facility().
> 
> Rather than checking for some known failures, check positively for the
> success response code 0x0001 and return -EIO for unrecognized failure
> response codes.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
>  chsc.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> index 8cf9905..f4183d6 100644
> --- a/drivers/s390/cio/chsc.c
> +++ b/drivers/s390/cio/chsc.c
> @@ -1115,6 +1115,9 @@ chsc_enable_facility(int operation_code)
>  		goto out;
>  	}
>  	switch (sda_area->response.code) {
> +	case 0x0001: /* everything ok */
> +		ret = 0;
> +		break;
>  	case 0x0003: /* invalid request block */
>  	case 0x0007:
>  		ret = -EINVAL;
> @@ -1123,6 +1126,8 @@ chsc_enable_facility(int operation_code)
>  	case 0x0101: /* facility not provided */
>  		ret = -EOPNOTSUPP;
>  		break;
> +	default: /* something went wrong */
> +		ret = -EIO;
>  	}
>   out:
>  	free_page((unsigned long)sda_area);

Many thanks,
Greg Smith


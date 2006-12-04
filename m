Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937004AbWLDPYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937004AbWLDPYx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937006AbWLDPYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:24:53 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:34948 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937004AbWLDPYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:24:52 -0500
Date: Mon, 4 Dec 2006 10:23:48 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: Re: [S390] cio: Make ccw_dev_id_is_equal() more robust.
Message-ID: <20061204152348.GA30961@filer.fsl.cs.sunysb.edu>
References: <20061204145624.GB32059@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204145624.GB32059@skybase>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 03:56:24PM +0100, Martin Schwidefsky wrote:
... 
> diff -urpN linux-2.6/include/asm-s390/cio.h linux-2.6-patched/include/asm-s390/cio.h
> --- linux-2.6/include/asm-s390/cio.h	2006-12-04 14:50:48.000000000 +0100
> +++ linux-2.6-patched/include/asm-s390/cio.h	2006-12-04 14:51:00.000000000 +0100
> @@ -278,7 +278,10 @@ struct ccw_dev_id {
>  static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
>  				      struct ccw_dev_id *dev_id2)
>  {
> -	return !memcmp(dev_id1, dev_id2, sizeof(struct ccw_dev_id));
> +	if ((dev_id1->ssid == dev_id2->ssid) &&
> +	    (dev_id1->devno == dev_id2->devno))
> +		return 1;
> +	return 0;
>  }

Why not just:

return ((dev_id1->ssid == ......) && (...));

?

Josef "Jeff" Sipek.

-- 
UNIX is user-friendly ... it's just selective about who it's friends are

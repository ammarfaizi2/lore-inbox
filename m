Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbVCDBrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbVCDBrY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVCDBoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:44:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40637 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262804AbVCDAFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:05:02 -0500
Message-ID: <4227A606.50703@pobox.com>
Date: Thu, 03 Mar 2005 19:04:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][16/26] IB/mthca: mem-free doorbell record writing
References: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>
In-Reply-To: <2005331520.WW3zbnVIUjZ4q0Ov@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Add a mthca_write_db_rec() to wrap writing doorbell records.  On
> 64-bit archs, this is just a 64-bit write, while on 32-bit archs it
> splits the write into two 32-bit writes with a memory barrier to make
> sure the two halves of the record are written in the correct order.

> +static inline void mthca_write_db_rec(u32 val[2], u32 *db)
> +{
> +	db[0] = val[0];
> +	wmb();
> +	db[1] = val[1];
> +}
> +


Are you concerned about ordering, or write-combining?

I am unaware of a situation where writes are re-ordered into a reversed, 
descending order for no apparent reason.

	Jeff



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTLWLqW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 06:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTLWLqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 06:46:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24767 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265110AbTLWLqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 06:46:21 -0500
Date: Tue, 23 Dec 2003 12:45:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Another dm and bio problem with 2.6.0
Message-ID: <20031223114553.GA1927@suse.de>
References: <1072114957.15546.23.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072114957.15546.23.camel@markh1.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22 2003, Mark Haverkamp wrote:
> This fixes a problem similar to the patch I submitted on 11/20
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106936439707962&w=2
> 
> In this case, though, the result is an:
> 
> "Incorrect number of segments after building list" message.
> 
> The macro __BVEC_START assumes a bi_idx of zero when the dm code can
> submit a bio with a non-zero bi_idx.  
> The code has been tested on an 8 way / 8gb OSDL STP machine with a 197G
> lvm volume running dbt2 test.
> 
> ===== include/linux/bio.h 1.34 vs edited =====
> --- 1.34/include/linux/bio.h	Sun Sep 21 14:50:33 2003
> +++ edited/include/linux/bio.h	Wed Dec 17 07:17:53 2003
> @@ -162,7 +162,7 @@
>   */
>  
>  #define __BVEC_END(bio)		bio_iovec_idx((bio), (bio)->bi_vcnt - 1)
> -#define __BVEC_START(bio)	bio_iovec_idx((bio), 0)
> +#define __BVEC_START(bio)	bio_iovec_idx((bio), (bio)->bi_idx)
>  #define BIOVEC_PHYS_MERGEABLE(vec1, vec2)	\
>  	((bvec_to_phys((vec1)) + (vec1)->bv_len) == bvec_to_phys((vec2)))
>  #define BIOVEC_VIRT_MERGEABLE(vec1, vec2)	\

Must have been some nasty debugging, good job. The patch is correct.

-- 
Jens Axboe


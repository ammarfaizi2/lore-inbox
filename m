Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264086AbUDGSeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDGSeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:34:19 -0400
Received: from holomorphy.com ([207.189.100.168]:57478 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264086AbUDGSeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:34:18 -0400
Date: Wed, 7 Apr 2004 11:34:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mc2
Message-ID: <20040407183416.GC30117@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040406221744.2bd7c7e4.akpm@osdl.org> <20040407180430.GA30117@holomorphy.com> <20040407180919.GB30117@holomorphy.com> <20040407112738.23d07088.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407112738.23d07088.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 11:27:38AM -0700, Andrew Morton wrote:
> I did it this way, relying on magical promotions:
> --- 25/fs/open.c~nfs-32bit-statfs-fix-warning-fix	2004-04-06 23:16:25.221685072 -0700
> +++ 25-akpm/fs/open.c	2004-04-06 23:16:25.225684464 -0700
> @@ -64,10 +64,10 @@ static int vfs_statfs_native(struct supe
>  			 * f_files and f_ffree may be -1; it's okay to stuff
>  			 * that into 32 bits
>  			 */
> -			if (st.f_files != 0xffffffffffffffffULL &&
> +			if (st.f_files != -1 &&
>  			    (st.f_files & 0xffffffff00000000ULL))
>  				return -EOVERFLOW;
> -			if (st.f_ffree != 0xffffffffffffffffULL &&
> +			if (st.f_ffree != -1 &&
>  			    (st.f_ffree & 0xffffffff00000000ULL))

Are you sure this works? IIRC -1 is promoted only afterward, yielding
on 64-bit (1UL << 32) - 1 instead of ~0UL, which was the issue with
init_task.cpus_allowed being initialized to -1 on 2.4.x. Maybe it's
better behaved in this instance (language lawyer territory).

-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCJDaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCJDaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 22:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVCJD1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 22:27:49 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:42898 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262371AbVCJD0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 22:26:23 -0500
Date: Wed, 9 Mar 2005 21:25:07 -0600
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
       paulus@samba.org
Subject: Re: [PATCH 2/2] No-exec support for ppc64
Message-ID: <20050310032507.GC20789@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com> <20050308171326.3d72363a.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308171326.3d72363a.moilanen@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 08, 2005 at 05:13:26PM -0600, Jake Moilanen wrote:
> diff -puN arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64 arch/ppc64/mm/hash_utils.c
> --- linux-2.6-bk/arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
> +++ linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c	2005-03-08 16:08:57 -06:00
> @@ -89,12 +90,23 @@ static inline void loop_forever(void)
>  		;
>  }
>  
> +int is_kernel_text(unsigned long addr)
> +{
> +	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
> +		return 1;
> +
> +	return 0;
> +}

This is used in two files, but never declared extern in the second file
(iSeries_setup.c). Should it go in a header file as a static inline
instead?

There also seems to be a local static is_kernel_text() in kallsyms that
overlaps (but it's not identical). Removing that redundancy can be taken
care of as a janitorial patch outside of the noexec stuff.



-Olof

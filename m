Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTJVV7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 17:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTJVV7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 17:59:14 -0400
Received: from zok.SGI.COM ([204.94.215.101]:44203 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261245AbTJVV7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 17:59:12 -0400
Date: Wed, 22 Oct 2003 14:58:50 -0700
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [PATCH] trivial ia64 numa/discontig fixes
Message-ID: <20031022215850.GA12706@sgi.com>
Mail-Followup-To: Alex Williamson <alex.williamson@hp.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
References: <1066859181.1191.96.camel@patsy.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066859181.1191.96.camel@patsy.fc.hp.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 03:46:21PM -0600, Alex Williamson wrote:
> --- linux-2.5/arch/ia64/mm/discontig.c	Wed Oct 22 15:13:48 2003
> +++ linux-2.5/arch/ia64/mm/discontig.c	Wed Oct 22 15:16:42 2003
> @@ -186,7 +186,7 @@
>  			 */
>  			for (cpu = 0; cpu < NR_CPUS; cpu++) {
>  				if (node == node_cpuid[cpu].nid) {
> -					memcpy(cpu_data, __phys_per_cpu_start,
> +					memcpy(__va(cpu_data), __phys_per_cpu_start,
>  					       __per_cpu_end-__per_cpu_start);
>  					__per_cpu_offset[cpu] =
>  						(char*)__va(cpu_data) -

If we put the __va() above where cpu_data is set, we can remove it from
both places in the loop...  Just thought that might be clearer since the
other assignments use __va() above.

Jesse

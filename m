Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVIHLSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVIHLSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 07:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVIHLSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 07:18:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29348 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932230AbVIHLSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 07:18:47 -0400
Date: Thu, 8 Sep 2005 06:17:31 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>, KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5][BUG] SUBCPUSETS: fix for cpusets minor problem
Message-ID: <20050908111731.GA19987@lnx-holt.americas.sgi.com>
References: <20050908054053.35DAD70031@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908054053.35DAD70031@sv1.valinux.co.jp>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 02:40:53PM +0900, KUROSAWA Takahiro wrote:
> This patch fixes minor problem that the CPUSETS have when files
> in the cpuset filesystem are read after lseek()-ed beyond the EOF.
> 
> Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
> 
> --- from-0001/kernel/cpuset.c
> +++ to-work/kernel/cpuset.c	2005-09-05 20:26:18.075772762 +0900
> @@ -984,6 +984,10 @@ static ssize_t cpuset_common_file_read(s
>  	*s++ = '\n';
>  	*s = '\0';
>  
> +	/* Do nothing if *ppos is at the eof or beyond the eof. */
> +	if (s - page <= *ppos)
> +		return 0;
> +
>  	start = page + *ppos;
>  	n = s - start;
>  	retval = n - copy_to_user(buf, start, min(n, nbytes));


Paul,  I think this should go in regardless of the other subcpuset
changes being proposed.  What do you think?

Robin

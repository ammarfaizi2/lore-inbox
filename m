Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTJQJcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTJQJcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:32:22 -0400
Received: from holomorphy.com ([66.224.33.161]:13959 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263355AbTJQJcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:32:21 -0400
Date: Fri, 17 Oct 2003 02:35:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: highmem-zone memory hotremoval test patch
Message-ID: <20031017093526.GF25291@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031017082835.713167007A@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017082835.713167007A@sv1.valinux.co.jp>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 05:28:35PM +0900, IWAMOTO Toshihiro wrote:
> diff -dpur linux-2.6.0-test1/fs/proc/kcore.c linux-2.6.0-test1-mh/fs/proc/kcore.c
> --- linux-2.6.0-test1/fs/proc/kcore.c	Mon Jul 14 12:34:39 2003
> +++ linux-2.6.0-test1-mh/fs/proc/kcore.c	Thu Jul 31 16:01:37 2003
> @@ -450,7 +450,7 @@ static ssize_t read_kcore(struct file *f
>  			}
>  			kfree(elf_buf);
>  		} else {
> -			if (kern_addr_valid(start)) {
> +			if (1 /*kern_addr_valid(start)*/) {
>  				unsigned long n;
>  
>  				n = copy_to_user(buffer, (char *)start, tsz);

kern_addr_valid() has been bogus garbage for a while, and smbfs and
ncpfs are swiss cheese. IMHO unless some arch gets its act together and
acquires a legitimate use for it, pgdat->valid_addr_bitmap and
kern_addr_valid() should be removed. And probably d_validate(), too.


-- wli

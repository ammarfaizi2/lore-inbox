Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUJQJa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUJQJa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 05:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269088AbUJQJa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 05:30:27 -0400
Received: from holomorphy.com ([207.189.100.168]:44950 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269083AbUJQJa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 05:30:26 -0400
Date: Sun, 17 Oct 2004 02:30:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, luc@saillard.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: rc4-mm1 and pwc-unofficial: kernel BUG and scheduling while atomic
Message-ID: <20041017093018.GY5607@holomorphy.com>
References: <20041017073614.GC7395@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017073614.GC7395@gamma.logic.tuwien.ac.at>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 09:36:14AM +0200, Norbert Preining wrote:
> @@ -1618,7 +1618,7 @@
>         pos = (unsigned long)pdev->image_data;
>         while (size > 0) {
>                 page = kvirt_to_pa(pos);
> -               if (remap_page_range(vma, start, page, PAGE_SIZE,
>                 PAGE_SHARED))
> +               if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
>                         return -EAGAIN;
>  
>                 start += PAGE_SIZE;
> the module compiled and loaded without problem, but when starting
> gnomemeeting I get the following kernel BUG and scheduling while atomic:

You need to right shift the argument by PAGE_SHIFT.


-- wli

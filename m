Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVHOJka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVHOJka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 05:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHOJka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 05:40:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932378AbVHOJk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 05:40:29 -0400
Date: Mon, 15 Aug 2005 10:40:22 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu
Subject: Re: [patch 18/39] remap_file_pages protection support: add VM_FAULT_SIGSEGV
Message-ID: <20050815104022.D19811@flint.arm.linux.org.uk>
Mail-Followup-To: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com,
	linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu
References: <20050812182145.DF52E24E7F3@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050812182145.DF52E24E7F3@zion.home.lan>; from blaisorblade@yahoo.it on Fri, Aug 12, 2005 at 08:21:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 08:21:45PM +0200, blaisorblade@yahoo.it wrote:
> @@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
>   * Used to decide whether a process gets delivered SIGBUS or
>   * just gets major/minor fault counters bumped up.
>   */
> -#define VM_FAULT_OOM	(-1)
> -#define VM_FAULT_SIGBUS	0
> -#define VM_FAULT_MINOR	1
> -#define VM_FAULT_MAJOR	2
> +#define VM_FAULT_OOM		(-1)
> +#define VM_FAULT_SIGBUS		0
> +#define VM_FAULT_MINOR		1
> +#define VM_FAULT_MAJOR		2
> +#define VM_FAULT_SIGSEGV	3
>  
>  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
>  

Please arrange for "success" values to be numerically larger than "failure"
values.  This will avoid breaking ARM.

Is there a reason why we don't use -ve numbers for failure and +ve for
success here?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

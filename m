Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWAESVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWAESVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAESVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:21:51 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:10213 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750724AbWAESVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:21:50 -0500
Date: Thu, 5 Jan 2006 13:18:32 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: dual line backtraces for i386.
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601051321_MC3-1-B55B-8147@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060105062208.GA12095@redhat.com>

On Thu, 5 Jan 2006 at 01:22:08 -0500, Dave Jones wrote:

> --- linux-2.6.15/arch/i386/kernel/traps.c~    2005-12-01 04:25:36.000000000 -0500
> +++ linux-2.6.15/arch/i386/kernel/traps.c     2005-12-01 04:36:19.000000000 -0500
> @@ -116,6 +116,7 @@ static inline unsigned long print_contex
>                               unsigned long *stack, unsigned long ebp)
>  {
>       unsigned long addr;
> +     char space=0;

        char space = 0;


> -                     printk("\n");
> +                     if (space == 0) {
> +                             printk("    ");
> +                             space = 1;
> +                     } else {
> +                             printk("\n");
> +                             space = 0;
> +                     }

Why not:

                        printk(space == 0 ? "     " : "\n");
                        space = !space;


> +     if (space==1)
> +             printk("\n");

        if (space == 1)

-- 
Chuck
Currently reading: _Thud!_ by Terry Pratchett

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVI1WPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVI1WPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVI1WPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:15:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:29136 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751126AbVI1WPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:15:49 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH 3/3] Gdt hotplug
Date: Thu, 29 Sep 2005 00:15:00 +0200
User-Agent: KMail/1.8.2
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeffrey Sheldon <jeffshel@vmware.com>, Ole Agesen <agesen@vmware.com>,
       Shai Fultheim <shai@scalex86.org>, Andrew Morton <akpm@odsl.org>,
       Jack Lo <jlo@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
References: <200509282144.j8SLi53a032237@zach-dev.vmware.com>
In-Reply-To: <200509282144.j8SLi53a032237@zach-dev.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509290015.02973.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 September 2005 23:44, Zachary Amsden wrote:
> As suggested by Andi Kleen, don't allocate a GDT page if there is already
> one present.  Needed for CPU hotplug.

Did I really suggest that? I think I suggested checking the return
value of gfp. Also get_zeroed_page() is slightly cleaner than GFP_ZERO.

-Andi

>
> Signed-off-by: Zachary Amsden <zach@vmware.com>
> Index: linux-2.6.14-rc1/arch/i386/kernel/smpboot.c
> ===================================================================
> --- linux-2.6.14-rc1.orig/arch/i386/kernel/smpboot.c	2005-09-20
> 20:38:22.000000000 -0700 +++
> linux-2.6.14-rc1/arch/i386/kernel/smpboot.c	2005-09-28 12:54:08.000000000
> -0700 @@ -898,7 +898,8 @@ static int __devinit do_boot_cpu(int api
>  	 * This grunge runs the startup process for
>  	 * the targeted processor.
>  	 */
> -	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
> +	if (!cpu_gdt_descr[cpu].address)
> +		cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
>
>  	atomic_set(&init_deasserted, 0);

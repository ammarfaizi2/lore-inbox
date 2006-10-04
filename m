Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030815AbWJDLRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030815AbWJDLRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030814AbWJDLRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:17:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:18610 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030815AbWJDLRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:17:17 -0400
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 2/12] i386: align data section to 4K boundary
Date: Wed, 4 Oct 2006 13:17:12 +0200
User-Agent: KMail/1.9.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003170628.GB3164@in.ibm.com>
In-Reply-To: <20061003170628.GB3164@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041317.12132.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 19:06, Vivek Goyal wrote:
> 
> o Currently there is no specific alignment restriction in linker script
>   and in some cases it can be placed non 4K aligned addresses. This fails
>   kexec which checks that segment to be loaded is page aligned.
> 
> o I guess, it does not harm data segment to be 4K aligned.

iirc P4 optimization guide even recommends to keep writable data 
away one page from code to avoid some cache invalidations. But:

> diff -puN arch/i386/kernel/vmlinux.lds.S~i386-force-data-section-to-4K-aligned arch/i386/kernel/vmlinux.lds.S
> --- linux-2.6.18-git17/arch/i386/kernel/vmlinux.lds.S~i386-force-data-section-to-4K-aligned	2006-10-02 13:17:58.000000000 -0400
> +++ linux-2.6.18-git17-root/arch/i386/kernel/vmlinux.lds.S	2006-10-02 14:38:17.000000000 -0400
> @@ -52,6 +52,7 @@ SECTIONS
>    }
>  
>    /* writeable */
> +  . = ALIGN(4096);
>    .data : AT(ADDR(.data) - LOAD_OFFSET) {	/* Data */
>  	*(.data)
>  	CONSTRUCTORS

I would move the ".tracedata" section behind it first.

-Andi

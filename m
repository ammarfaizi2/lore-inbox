Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUJ2Jqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUJ2Jqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 05:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbUJ2Jqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 05:46:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:44238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261396AbUJ2JpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 05:45:13 -0400
Date: Fri, 29 Oct 2004 02:43:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com, varap@us.ibm.com,
       fastboot@osdl.org
Subject: Re: Compile error on 2.6.10-rc1-mm1
Message-Id: <20041029024305.7bd9778c.akpm@osdl.org>
In-Reply-To: <41820F72.5020203@in.ibm.com>
References: <41820F72.5020203@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> The compile time error that few people have been seeing with 
>  the last couple of -mm releases are due to the changes 
>  introduced to arch/i386/kernel/vmlinux.lds.S to enable kexec 
>  based crashdumps.
> ...
>  --- linux-2.6.10-rc1/arch/i386/kernel/vmlinux.lds.S~kdump-fix-bss-compile-error	2004-10-28 15:15:43.000000000 +0530
>  +++ linux-2.6.10-rc1-hari/arch/i386/kernel/vmlinux.lds.S	2004-10-28 15:18:04.000000000 +0530
>  @@ -117,8 +117,9 @@ SECTIONS
>     /* freed after init ends here */
>   	
>     __bss_start = .;		/* BSS */
>  +  .bss.page_aligned  : AT(ADDR(.bss.page_aligned) - LOAD_OFFSET) {
>  +	*(.bss.page_aligned) }
>     .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
>  -	*(.bss.page_aligned)
>   	*(.bss)
>     }
>     . = ALIGN(4);

It's hard to see how that could go wrong.  Did you compare the before- and
after- output from `objdump -h vmlinux'?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932978AbWFZTq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbWFZTq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932980AbWFZTq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:46:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:12202 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932978AbWFZTq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:46:58 -0400
Date: Mon, 26 Jun 2006 14:46:11 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-390@vm.marist.edu
Subject: Re: [PATCH] s390: fix duplicate export of overflow{ug}id
Message-ID: <20060626194611.GC32035@sergelap.austin.ibm.com>
References: <20060626193141.GB32035@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626193141.GB32035@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com):
> overflowuid and overflowgid were exported twice.  Remove the export
> from s390_ksyms.c
> 
> Signed-off-by: "Serge E. Hallyn" <serue@us.ibm.com>
> 
> ---
> 
>  arch/s390/kernel/s390_ksyms.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> b89fdbbb0859c2ed03246a822e278bf9a31ae054
> diff --git a/arch/s390/kernel/s390_ksyms.c b/arch/s390/kernel/s390_ksyms.c
> index 4176c77..0886e73 100644
> --- a/arch/s390/kernel/s390_ksyms.c
> +++ b/arch/s390/kernel/s390_ksyms.c
> @@ -46,8 +46,6 @@ EXPORT_SYMBOL(__down_interruptible);
>   */
>  extern int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs);
>  EXPORT_SYMBOL(dump_fpu);
> -EXPORT_SYMBOL(overflowuid);
> -EXPORT_SYMBOL(overflowgid);
>  EXPORT_SYMBOL(empty_zero_page);

Hmm, ok, I see that this only happens when I have a busted .config
(and have no idea how CONFIG_UID16 came to be set).

I assume CONFIG_UID16 is not a valid option for s390?  If that's the
case, then please ignore.  If it is, then instead of removing these
we should probably put them in #ifndef CONFIG_UID16?

thanks,
-serge

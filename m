Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWFUJ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWFUJ0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWFUJ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:26:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:937 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932511AbWFUJ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:26:21 -0400
Subject: Re: [patch] i386: halt the CPU on serious errors
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
References: <200606200059_MC3-1-C2E8-8C46@compuserve.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:26:10 +0200
Message-Id: <1150881970.3057.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 00:55 -0400, Chuck Ebbert wrote:
> Halt the CPU when serious errors are encountered and we
> deliberately go into an infinite loop.
> 
> Suggested by Andreas Mohr.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> 
> --- 2.6.17-32.orig/arch/i386/kernel/crash.c
> +++ 2.6.17-32/arch/i386/kernel/crash.c
> @@ -113,8 +113,8 @@ static int crash_nmi_callback(struct pt_
>  	disable_local_APIC();
>  	atomic_dec(&waiting_for_crash_ipi);
>  	/* Assume hlt works */
> -	halt();
> -	for(;;);
> +	for (;;)
> +		halt();

if halt is fall through (as you suggest).. this would want a cpu_relax()
as well..


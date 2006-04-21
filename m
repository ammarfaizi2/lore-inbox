Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWDUVVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWDUVVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWDUVVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:21:12 -0400
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:11705 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S932483AbWDUVVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:21:10 -0400
Date: Fri, 21 Apr 2006 17:21:09 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: Tony Jones <tonyj@suse.de>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org, linux-audit@redhat.com
Subject: Re: [RFC][PATCH 9/11] security: AppArmor - Audit changes
Message-ID: <20060421212109.GB1903@zk3.dec.com>
Mail-Followup-To: Tony Jones <tonyj@suse.de>,
	linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
	linux-security-module@vger.kernel.org, linux-audit@redhat.com
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175018.29149.391.sendpatchset@ermintrude.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419175018.29149.391.sendpatchset@ermintrude.int.wirex.com>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Jones wrote:     [Wed Apr 19 2006, 01:50:18PM EDT]
> This patch adds AppArmor support to the audit subsystem.
> 
> It creates id 1500 (already included in the the upstream auditd package) for 
> AppArmor messages.
> 
> It also exports the audit_log_vformat function (analagous to having both
> printk and vprintk exported).

linux-audit (cc'd) will likely want to review these changes.

> 
> Signed-off-by: Tony Jones <tonyj@suse.de>
> 
> ---
>  include/linux/audit.h |    5 +++++
>  kernel/audit.c        |    3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.17-rc1.orig/include/linux/audit.h
> +++ linux-2.6.17-rc1/include/linux/audit.h
> @@ -95,6 +95,8 @@
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
>  #define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
>  
> +#define AUDIT_AA		1500	/* AppArmor audit */
> +
>  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
>  
>  /* Rule flags */
> @@ -349,6 +351,9 @@
>  				      __attribute__((format(printf,4,5)));
>  
>  extern struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type);
> +extern void		    audit_log_vformat(struct audit_buffer *ab,
> +					      const char *fmt, va_list args)
> +			    __attribute__((format(printf,2,0)));
>  extern void		    audit_log_format(struct audit_buffer *ab,
>  					     const char *fmt, ...)
>  			    __attribute__((format(printf,2,3)));
> --- linux-2.6.17-rc1.orig/kernel/audit.c
> +++ linux-2.6.17-rc1/kernel/audit.c
> @@ -797,7 +797,7 @@
>   * will be called a second time.  Currently, we assume that a printk
>   * can't format message larger than 1024 bytes, so we don't either.
>   */
> -static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
> +void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
>  			      va_list args)
>  {
>  	int len, avail;
> @@ -999,4 +999,5 @@
>  EXPORT_SYMBOL(audit_log_start);
>  EXPORT_SYMBOL(audit_log_end);
>  EXPORT_SYMBOL(audit_log_format);
> +EXPORT_SYMBOL(audit_log_vformat);
>  EXPORT_SYMBOL(audit_log);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

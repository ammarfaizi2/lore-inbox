Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTHQQrv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 12:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270378AbTHQQrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 12:47:51 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:47365
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270370AbTHQQrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 12:47:49 -0400
Date: Sun, 17 Aug 2003 09:47:47 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Marco d'Itri" <md@Linux.IT>, linux-kernel@vger.kernel.org
Subject: prefetchnta on athlon was: Re: an oops in 2.6-test2 (oops)
Message-ID: <20030817164747.GW1027@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Marco d'Itri <md@Linux.IT>,
	linux-kernel@vger.kernel.org
References: <20030816112719.GA1073@wonderland.linux.it> <20030816122640.69650c65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816122640.69650c65.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 12:26:40PM -0700, Andrew Morton wrote:
> And you'll continue to get them until someone does something about it. 
> Discussion seemed to die off on this problem.
> 
> Until it is sorted, something like this is needed.
> 
> 
> diff -puN include/asm-i386/processor.h~disble-athlon-prefetch include/asm-i386/processor.h
> --- 25/include/asm-i386/processor.h~disble-athlon-prefetch	2003-08-16 12:22:32.000000000 -0700
> +++ 25-akpm/include/asm-i386/processor.h	2003-08-16 12:23:29.000000000 -0700
> @@ -568,6 +568,8 @@ static inline void rep_nop(void)
>  #define ARCH_HAS_PREFETCH
>  extern inline void prefetch(const void *x)
>  {
> +	if (current_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return;

Andrew, if you put this patch in -mm please add a nice big comment above it,
and put it in the "must fix before 2.6.0" list.

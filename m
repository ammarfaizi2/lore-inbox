Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbWGEXYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbWGEXYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWGEXYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:24:43 -0400
Received: from ozlabs.org ([203.10.76.45]:59058 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965063AbWGEXYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:24:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17580.18080.497286.940626@cargo.ozlabs.ibm.com>
Date: Thu, 6 Jul 2006 09:09:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
In-Reply-To: <1152095066.32572.49.camel@pmac.infradead.org>
References: <20060705092254.GA30744@redhat.com>
	<20060705023641.21507b34.akpm@osdl.org>
	<1152092585.32572.45.camel@pmac.infradead.org>
	<20060705094657.GB1877@redhat.com>
	<20060705025744.ea6ee5ed.akpm@osdl.org>
	<1152095066.32572.49.camel@pmac.infradead.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:

> +static inline cputime64_t jiffies64_to_cputime64(const u64 jif)
> +{
> +	cputime_t ct;
> +	u64 sec;
> +
> +	/* have to be a little careful about overflow */
> +	ct = jif % HZ;
> +	sec = jif / HZ;

I think we want to use do_div here, just in case we ever get around to
implementing this stuff on ppc32.

Paul.

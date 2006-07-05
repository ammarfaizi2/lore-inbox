Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWGEJmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWGEJmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWGEJmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:42:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17800 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964778AbWGEJml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:42:41 -0400
Date: Wed, 5 Jul 2006 05:42:27 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, dwmw2@redhat.com
Subject: Re: [CPUFREQ] Fix implicit declarations in ondemand.
Message-ID: <20060705094227.GA1877@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, dwmw2@redhat.com
References: <20060705092254.GA30744@redhat.com> <20060705023641.21507b34.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060705023641.21507b34.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 02:36:41AM -0700, Andrew Morton wrote:
 > On Wed, 5 Jul 2006 05:22:54 -0400
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > drivers/cpufreq/cpufreq_ondemand.c: In function ‘dbs_check_cpu’:
 > > drivers/cpufreq/cpufreq_ondemand.c:238: error: implicit declaration of function ‘jiffies64_to_cputime64’
 > > drivers/cpufreq/cpufreq_ondemand.c:239: error: implicit declaration of function ‘cputime64_sub’
 > > 
 > > Signed-off-by: Dave Jones <davej@redhat.com>
 > > 
 > > --- linux-2.6/drivers/cpufreq/cpufreq_ondemand.c~	2006-07-05 05:19:26.000000000 -0400
 > > +++ linux-2.6/drivers/cpufreq/cpufreq_ondemand.c	2006-07-05 05:20:01.000000000 -0400
 > > @@ -18,6 +18,7 @@
 > >  #include <linux/jiffies.h>
 > >  #include <linux/kernel_stat.h>
 > >  #include <linux/mutex.h>
 > > +#include <asm/cputime.h>
 > >  
 > 
 > But kernel_stat.h already includes cputime.h, as does sched.h, and pretty
 > much everything pulls in sched.h.
 > 
 > It's not bad to avoid a dependency upon nested includes, but I do wonder
 > how this error came about??

Yeah, this is the wrong fix. Turns out it blew up on ppc64, which doesn't
have those functions in its cputime.h

hrmph.

		Dave

-- 
http://www.codemonkey.org.uk

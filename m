Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUEZWeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUEZWeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUEZWeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:34:06 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:34482 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265840AbUEZWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:34:03 -0400
Date: Wed, 26 May 2004 23:32:55 +0100
From: Dave Jones <davej@redhat.com>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP support for drain local pages.
Message-ID: <20040526223255.GB15278@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40B473F7.4000100@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B473F7.4000100@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2004 at 08:39:51PM +1000, Nigel Cunningham wrote:

 > +#ifdef CONFIG_SMP
 > +static void __smp_drain_local_pages(void * data)
 > +{
 > +       drain_local_pages();
 > +}
 > +
 > +void smp_drain_local_pages(void)
 > +{
 > +       smp_call_function(__smp_drain_local_pages, NULL, 0, 1);
 > +       drain_local_pages();
 > +}
 > +#else
 > +void smp_drain_local_pages(void)
 > +{
 > +       drain_local_pages();
 > +}
 > +#endif
 >  #endif /* CONFIG_PM */

if you use on_each_cpu() you can do away with the ifdef.
It also takes care of preemption issues.

		Dave


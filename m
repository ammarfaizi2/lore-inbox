Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbTFFMld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 08:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbTFFMld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 08:41:33 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:58078 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261324AbTFFMlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 08:41:32 -0400
Date: Fri, 6 Jun 2003 18:28:07 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: Re: How to initialize complex per-cpu variables?
Message-ID: <20030606125807.GA2561@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <A46BBDB345A7D5118EC90002A5072C780D6F13E8@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780D6F13E8@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 09:35:37PM +0000, Perez-Gonzalez, Inaky wrote:
> Now the question is: how do I walk each structure that is
> associated to each CPU - I mean, something like:
> 
> struct rtf_h *h;
> for_each_cpu (h, rtf_lh) {
> 	rtf_h_init (h);
> }

One way to do this would be to do -

for (i = 0; i < NR_CPUS; i++) {
	if (cpu_possible(i))
		rtf_h_init(&per_cpu(rtf_lh, i));
}


However you might want to actually use the CPU notifiers to do this. See
rcu_init() in kernel/rcupdate.c.

Thanks
Dipankar

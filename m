Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUENDRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUENDRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 23:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUENDRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 23:17:08 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:48958 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264272AbUENDRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 23:17:02 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow console drivers to be called early
Date: Thu, 13 May 2004 20:16:18 -0700
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <200405131547.14062.jbarnes@engr.sgi.com> <20040513194408.0e6ba433.akpm@osdl.org>
In-Reply-To: <20040513194408.0e6ba433.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132016.18570.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 13, 2004 7:44 pm, Andrew Morton wrote:
> >  -	if (!cpu_online(smp_processor_id()) &&
> >  +	if (!early_printk_ok && !cpu_online(smp_processor_id()) &&
>
> Is it not possible to mark this cpu as being online?   It sure seems to be.

But then we miss out on all the good stuff happening in setup_arch since 
smp_processor_id() isn't set in cpu_online_map until smp_prepare_boot_cpu.  I 
can try upping it in arch code, but iirc, I had problems with that in older 
kernels due to the expectations of some of the other CPU upping code.  I'll 
give it a try again and either give you a good answer or send a more 
appropriate patch to David.

Thanks,
Jesse

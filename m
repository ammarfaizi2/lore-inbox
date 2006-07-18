Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWGRVAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWGRVAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWGRVAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:00:32 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34947 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932403AbWGRVA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:00:28 -0400
Date: Tue, 18 Jul 2006 14:00:58 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: David Miller <davem@davemloft.net>
Cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, akpm@osdl.org, rusty@rustcorp.com.au,
       zach@vmware.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 23/33] subarch TLB support
Message-ID: <20060718210058.GF2654@sequoia.sous-sol.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091954.271792000@sous-sol.org> <20060718.133924.71552173.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060718.133924.71552173.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Miller (davem@davemloft.net) wrote:
> From: Chris Wright <chrisw@sous-sol.org>
> Date: Tue, 18 Jul 2006 00:00:23 -0700
> 
> > +        BUG_ON(HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF) < 0);
> 
> Although it happens to work currently, I think we should get out of
> the habit of putting operations with wanted side effects into BUG_ON()
> calls.  The following is therefore more preferable:
> 
> 	ret = HYPERVISOR_mmuext_op(&op, 1, NULL, DOMID_SELF);
> 	BUG_ON(ret < 0);
> 
> If this were ASSERT() in userspace, turning off debugging at build
> time would make the evaluations inside of the macro never occur.  It
> is my opinion that BUG_ON() should behave similarly.

Good point, I'll clean those up.

thanks,
-chris

Return-Path: <linux-kernel-owner+w=401wt.eu-S932342AbWLLS53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWLLS53 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWLLS52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:57:28 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34758 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932342AbWLLS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:57:27 -0500
Date: Tue, 12 Dec 2006 10:57:17 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: jacliburn@bellsouth.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation
 behavior
Message-Id: <20061212105717.f539fb73.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0612110930180.500@schroedinger.engr.sgi.com>
References: <457C64C5.9030108@bellsouth.net>
	<20061210124907.60c4a0aa.pj@sgi.com>
	<20061210141435.afac089d.akpm@osdl.org>
	<Pine.LNX.4.64.0612110855380.500@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0612110930180.500@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> +		if (local_flags & __GFP_WAIT)
> +			local_irq_enable();
> +		kmem_flagcheck(cache, flags);
>  		obj = kmem_getpages(cache, flags, -1);
> +		if (local_flags & __GFP_WAIT)
> +			local_irq_disable();

This seems strange to me.  I am surprised that it is ok for a routine
that is called with irq's disabled, to enable them momentarilly.

I'd have thought the caller of this routine, who called it with irq's
disabled, would expect irq's to remain disabled across the entire call.

I guess I'm assuming that disabled irq's are like a lock, not to be
momentarilly dropped by some nested routine without the explicit
awareness and consent of the caller.

But I don't really know what I'm talking about here.  Perhaps some
more clueful soul can educate me.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbUCZVPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264140AbUCZVPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:15:34 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:45791 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264133AbUCZVP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:15:29 -0500
Subject: Re: [patch 1/22] Add __early_param for all arches
From: David Woodhouse <dwmw2@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040326210355.D17638@flint.arm.linux.org.uk>
References: <20040324235722.QDLK23486.fed1mtao04.cox.net@localhost.localdomain>
	 <20040324195502.00a5b148.akpm@osdl.org>
	 <1080210253.29835.37.camel@hades.cambridge.redhat.com>
	 <20040326210355.D17638@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1080335720.29835.294.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 26 Mar 2004 21:15:21 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 21:03 +0000, Russell King wrote:
> So we require, in order:
> 
> - mem= to be parsed
> - bootmem to be initialised
> - drivers which want to allocate from bootmem to then be
>   initialised
> - setup rest of the kernel
> - final command line parsing
> 
> which gives us three stages of command line parsing.

No, because the existing command line parsing doesn't get to use the
slab, so there's no need for us to add that final item in your list. 

Leave it out, and you have what Tom's already implemented. The current
__setup() calls are allowed to use bootmem but not slab, and the
__early_param() calls aren't even allowed to use bootmem.

-- 
dwmw2


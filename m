Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbUKDTEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUKDTEm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUKDTEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:04:42 -0500
Received: from soundwarez.org ([217.160.171.123]:52401 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262351AbUKDTDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:03:23 -0500
Subject: Re: [patch] kobject_uevent: fix init ordering
From: Kay Sievers <kay.sievers@vrfy.org>
To: Robert Love <rml@novell.com>
Cc: Greg KH <greg@kroah.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, davem@redhat.com,
       herbert@gondor.apana.org.au
In-Reply-To: <1099592851.31022.145.camel@betsy.boston.ximian.com>
References: <20041104154317.GA1268@krispykreme.ozlabs.ibm.com>
	 <20041104180550.GA16744@kroah.com>
	 <1099592851.31022.145.camel@betsy.boston.ximian.com>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 20:04:02 +0100
Message-Id: <1099595042.8249.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 13:27 -0500, Robert Love wrote:
> Greg!
> 
> Looks like kobject_uevent_init is executed before netlink_proto_init and
> consequently always fails.  Not cool.
> 
> Attached patch switches the initialization over from core_initcall (init
> level 1) to postcore_initcall (init level 2).  Netlink's initialization
> is done in core_initcall, so this should fix the problem.  We should be
> fine waiting until postcore_initcall.

Looks good. Don't know why this never failed on any kernel I used.
Does the failure happens on a SMP kernel?

>  static int send_uevent(const char *signal, const char *obj, const void *buf,
> -			int buflen, int gfp_mask)
> +		       int buflen, int gfp_mask)
                         ^^^^^^^^^^
This has changed and will not apply.

Best,
Kay


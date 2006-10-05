Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751482AbWJEPHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbWJEPHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWJEPHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:07:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23513 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751271AbWJEPHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:07:19 -0400
Subject: Re: 2.6.18-mm3 oops in xfrm_register_mode
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Steve Fox <drfickle@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <1159995731.28106.82.camel@flooterbu>
References: <20061003001115.e898b8cb.akpm@osdl.org>
	 <4523CFEF.6000007@us.ibm.com>  <20061004095703.5c843514.akpm@osdl.org>
	 <1159995731.28106.82.camel@flooterbu>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 08:06:51 -0700
Message-Id: <1160060811.9569.40.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 16:02 -0500, Steve Fox wrote:
> On Wed, 2006-10-04 at 09:57 -0700, Andrew Morton wrote:
> 
> > You might well find this bisection lands you on origin.patch.  ie: a
> > mainline bug.  I note that David merged a few more xfrm fixes this morning.
> > 
> > So to confirm that, first test just origin.patch and if that fails, test
> > git-of-the-moment.  If that doesn't fail, they fixed it.
> 
> origin.patch from --m3 failed. Unfortunately so did a fresh clone of
> Linus's git tree.
> 

I am not an expert in that area, but your stack trace made me curious.
Looking at the dis-assembly, line of code in question is:

	        if (likely(modemap[mode->encap] == NULL)) {

Register contents indicate that, its called as

	xfrm_register_mode(&xfrm4_tunnel_mode, AF_INET);
or
	xfrm_register_mode(&xfrm4_transport_mode, AF_INET);

(family is AF_INET).

The invalid deref is due to modemap = 0x7ff (RAX: 00000000000007ff)

Since its so easy to reproduce, can you add a printk before
this check to dump mode->encap and modemap, afinfo, family etc ?
Just curious ..


Thanks,
Badari


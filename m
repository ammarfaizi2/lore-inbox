Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUDMIba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUDMIb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:31:29 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:36113 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261603AbUDMIb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:31:28 -0400
Date: Tue, 13 Apr 2004 09:36:13 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PAT support
Message-ID: <4680790.1081848973@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <20040412222928.GP506@hygelac>
References: <20040412222928.GP506@hygelac>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 12 April 2004 17:29 -0500 Terence Ripperda <tripperda@nvidia.com>
wrote:

> quite a while back, I sent out email about adding Page Attribute Table
> support to the kernel (http://www.ker
> neltraffic.org/kernel-traffic/kt20030616_219.html#3).

> this current patch includes the original PAT support and the new cachemap
> mechanism. note that the cachemap mechanism does not actually change any
> caching attributes, it only keeps track of the attributes and tests
> regions. I think the end idea would be that drivers would use the normal
> ioremap/change_page_attr/remap_page_range mechanisms like they already
> do, and these mechanisms would in turn use cachemap to make sure there's
> no conflicts. I'm completely open to how any specific details should
> work, and any changes needed to be made.

Yeah, I've experemented recently with PAT too.  Not had a chance to look at
the code in any specifics.  But I did notice there appear to be no notes or
warnings on the issues of using PAT based mappings.  Cirtainly there are
some _very_ onerus restrictions which I have personally tested and found to
be true :(.  Perhaps we could get some big fat warning style comments.

Cirtainly the documentation is _very_ specific about this limitation, I
think I saw this being implmented in the code.

+ * According to the INTEL documentation it is the systems responsibility
+ * to ensure that the PAT registers are kept in agreement on all processors
+ * in a system.  Changing these registers must occu in a manner which
+ * maintains the consistency of the processor caches and translation
+ * lookaside buggers (TLB).  

Also, I have confirmed that if you have any Intel processors which do not
have the SS (Self Snoop) capability, you cannot have two independent
mappings to a page with different cache attributes.  I have been hit by
this and you get stale data returned from the cache.

-apw

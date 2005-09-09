Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbVIIIGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVIIIGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIIIGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:06:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:47022 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751444AbVIIIGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:06:38 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>, jbeulich@novell.com
Subject: Re: [PATCH 2.6.13] x86_64: Rename KDB_VECTOR to NMI_VECTOR
Date: Fri, 9 Sep 2005 10:06:31 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>
References: <20050908163928.GS3966@smtp.west.cox.net>
In-Reply-To: <20050908163928.GS3966@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091006.31824.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 September 2005 18:39, Tom Rini wrote:
> The existing hook from KDB in the IPI code is really just a hook for the
> NMI vector.  We rename the vector thusly and then it's up to the
> debugger to handle things from do_default_nmi().

Jan Beulich pointed out some problems with this:

- First NMI vector is always 2 in the x86 architecture, so calling
another vector NMI_VECTOR is misleading.

- And when an NMI is forced in ICR the x86 architecture specifies
that the interrupt is delivered to vector 2.

Intel IA32  vol 3 8-23:

>>

100 (NMI) Delivers an NMI interrupt to the target processor
          or processors. The vector information is ignored.
<<

So how did this ever work?  I suspect you just got reentered
via the hooks in the NMI handler, but never through this vector.

I think I'll just remove this unless someone can explain how
it is supposed to work.

Thanks,
-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVK3Pev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVK3Pev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVK3Pev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:34:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6825 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751275AbVK3Peu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:34:50 -0500
Subject: Re: [PATCH 0/9] x86-64 put current in r10
From: Arjan van de Ven <arjan@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051130151847.GE5706@mea-ext.zmailer.org>
References: <20051130042118.GA19112@kvack.org>
	 <20051130151847.GE5706@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 16:34:33 +0100
Message-Id: <1133364873.2825.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-30 at 17:18 +0200, Matti Aarnio wrote:
> On Tue, Nov 29, 2005 at 11:21:18PM -0500, Benjamin LaHaise wrote:
> > Date:	Tue, 29 Nov 2005 23:21:18 -0500
> > From:	Benjamin LaHaise <bcrl@kvack.org>
> > To:	Andi Kleen <ak@suse.de>
> > Cc:	linux-kernel@vger.kernel.org
> > Subject: [PATCH 0/9] x86-64 put current in r10
> > 
> > Hello Andi,
> > 
> > The following emails contain the patches to convert x86-64 to store current 
> > in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).  This 
> > provides a significant amount of code savings (~43KB) over the current 
> > use of the per cpu data area.  I also tested using r15, but that generated 
> > code that was larger than that generated with r10.  This code seems to be 
> > working well for me now (it stands up to 32 and 64 bit processes and ptrace 
> > users) and would be a good candidate for further exposure.
> 
> I would rather prefer NOT to introduce this at this time.
> My primary concern is that during "even numbered series" there
> should not be radical internal ABI/API changes, like this one.

this isn't a radical API change actually, and.. well there is no kernel
ABI. If you care about ABI.. that breaks all the time anyway. Not just a
little bit, but highly radical.


> In 2.7 it can be introduced, by all means.

There is no 2.7, and the current development model also is that there
won't be one until the development model changes. 

> Indeed at the moment my thinking is, that X86-64 is way more UNSTABLE,
> than it should be.  (And Linux kernel overall, but that is another story.)

the funny thing is that this is a very localized change compared to many
of the other things going on, and unlikely to cause any major issues
with the kernel code. And the changes have clear gains in size and
probably also in speed (segment accesses are not cheap)

So personally I don't think your objections make sense in todays
reality.

Greetings,
    Arjan van de Ven


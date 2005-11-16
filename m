Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVKPGy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVKPGy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKPGy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:54:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48598 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751184AbVKPGyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:54:55 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: "Wed, 16 Nov 2005 00:41:11 +0100" <grundig@teleline.es>,
       Bernd Petrovitsch <bernd@firmix.at>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <DCB14CD5-D70E-4CA5-984A-F61DFB104E05@comcast.net>
References: <20051116004111.45f3f704.grundig@teleline.es>
	 <DCB14CD5-D70E-4CA5-984A-F61DFB104E05@comcast.net>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 07:54:47 +0100
Message-Id: <1132124087.2834.1.camel@laptopd505.fenrus.org>
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

On Tue, 2005-11-15 at 18:56 -0500, Parag Warudkar wrote:
> On Nov 15, 2005, at 6:41 PM, Wed, 16 Nov 2005 00:41:11 +0100 wrote:
> 
> >
> >> documentation for broadcom wireless:
> >> http://bcm-specs.sipsolutions.net/
> >> embrionic driver based on this spec:
> >> http://bcm43xx.berlios.de/
> >
> >
> > Maybe a good deal would be to delay the 4K patch until some  
> > preliminary
> > version of those is merged?
> 
> Andi had some pretty valid comments against the 4K approach.
> Here - http://lkml.org/lkml/2005/9/6/4
> I didn't see anyone contradicting his opinion. Seems very plausible  
> to me.

the only argument I see is "we had overflows in 2.4 with 8k". In fact
that is part of why 4K stacks was done! With 4k/4k stacks there is MORE
stack space than in 2.4. Most of the overflows I've seen in 2.4 were
nested interrupts with complex softirqs; with the 4k/4k stack approach
interrupts have MORE stack space available than in 2.4, making overflows
less likely. In addition the 2.6 kernel has undergone a "stack diet",
the final piece of which is the IO submission change that is now in -mm.




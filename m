Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVKKJrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVKKJrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbVKKJrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:47:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9882 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932319AbVKKJrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:47:17 -0500
Subject: Re: [patch 02/02] Debug option to write-protect rodata: the write
	protect logic and config option
From: Arjan van de Ven <arjan@infradead.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Josh Boyer <jdub@us.ibm.com>, linux-kernel@vger.kernel.org, ak@suse.de,
       akpm@osdl.org
In-Reply-To: <2cd57c900511110139v221ed3f3m@mail.gmail.com>
References: <20051107105624.GA6531@infradead.org>
	 <20051107105807.GB6531@infradead.org>
	 <1131372374.23658.1.camel@windu.rchland.ibm.com>
	 <1131373248.2858.17.camel@laptopd505.fenrus.org>
	 <2cd57c900511110139v221ed3f3m@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 10:47:07 +0100
Message-Id: <1131702428.2833.8.camel@laptopd505.fenrus.org>
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

> people objecting to that.
> >
> > (It's not clear cut: while the last bit of the kernel no longer is
> > covered by a 2Mb tlb, most intel cpus have very few of such tlbs in the
> > first place and this would free up one such tlb for other things (say
> > the stack data) or even the userspace database), so it's not all that
> > clear cut what the cost of this is)
> 
> I'm dumb. But how is "the last bit of the kernel no longer is covered
> by a 2Mb tlb"? Could you explain a bit more?

in memory it'll look something like this

0                 2                   4                         6
-- kernel text -- + -- kernel text -- + --- k. text-- rodata -- + --    

normally the range from 0 to 6 is covered with 2Mb tlb's.
Now to make rodata read only, the hugetlb entry covering 4-6 Mb range
needs to be split into 4Kb entries, so that the rodata portion can have
different permissions than the rest of that range.



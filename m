Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVKNUw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVKNUw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVKNUw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:52:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38539 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932118AbVKNUw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:52:58 -0500
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
From: Arjan van de Ven <arjan@infradead.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4378F4BE.6010207@vmware.com>
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	 <4374FB89.6000304@vmware.com>
	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	 <20051113074241.GA29796@redhat.com>
	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>
	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>
	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
	 <4378E97E.2060707@vmware.com>
	 <1131997971.2821.68.camel@laptopd505.fenrus.org>
	 <4378F4BE.6010207@vmware.com>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 21:52:46 +0100
Message-Id: <1132001567.2821.71.camel@laptopd505.fenrus.org>
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


> 
> Runtime tricks that increase complexity cost, yes.  It's all a question 
> of measured gain vs. complexity.  But a couple of percent gained on an 
> overall basis can be magnified enormously if you are looking at a 
> workload that stresses a particular path. 

a couple of percents sounds really really high to me. If it's really
that then I think Andi's conclusion is wrong with respect to that
locking cliff; if we spend a few percent of our performance on locks in
the uncontended case we're way over the edge in my opinion.

>  I would expect some of those 
> gains to be non-trivial, especially if considering the optimizations you 
> could do on page table updates knowing you needn't worry about SMP 

page table updates happen in the hypervisor in a xen like
paravirtualized setup right? so that happens outside the kernel..



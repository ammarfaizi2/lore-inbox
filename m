Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVKNTx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVKNTx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKNTx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:53:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751268AbVKNTx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:53:29 -0500
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
In-Reply-To: <4378E97E.2060707@vmware.com>
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
Content-Type: text/plain
Date: Mon, 14 Nov 2005 20:52:51 +0100
Message-Id: <1131997971.2821.68.camel@laptopd505.fenrus.org>
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

On Mon, 2005-11-14 at 11:46 -0800, Zachary Amsden wrote:

> It seems that SMP vs. UP lock / spinlock overhead is relevant even for 
> future, multi-core CPUs in a virtualization context, as the notion of 
> hotplug here is based on scheduling constraints of the virtualization 
> engine, and the kernel can quite readily end up with only one VCPU.


this assumes that you don't just always want to assume and use SMP
primitives in a virtualized context. I sort of question that assumption;
sure these things have overhead, especially "lock", but if the solution
is more complexity and weird things to hide that half-percent or less of
performance difference... then do remember that such complexity is not
free either. Runtime tricks cost. 


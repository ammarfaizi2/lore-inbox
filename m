Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264943AbUFGRIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUFGRIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUFGRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:08:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28312 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264943AbUFGRI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:08:26 -0400
Date: Mon, 7 Jun 2004 16:19:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Mike McCormack <mike@codeweavers.com>, linux-kernel@vger.kernel.org
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040607141903.GA20863@elte.hu>
References: <40C2B51C.9030203@codeweavers.com> <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com> <20040606081021.GA6463@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606081021.GA6463@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > It seems Linus's kernel does that quite well, but some vendors seem not 
> > to care too much about breaking Wine.
> 
> Why should they?  You need to fix up the broken assumptions in wine.

for the record, i personally do care about Wine alot, and i'd like to
repeat that exec-shield did not break any _existing_ binaries. It broke
_newly_ compiled binaries that got the PT_GNU_STACK flag.

i can very well understand the frustration of the Wine people - dealing
with such issues doesnt give a feeling of advance, because you are
working on solving an issue that didnt exist before.

prelink might have broken other assumptions of Wine - one way around
that is to compile Wine as a PIE binary (or to link it statically). 
prelink is a very important feature as well, from which Wine does
benefit as well.

Wine is in a really difficult position (due to the complex task it
achieves) and is more sensitive to VM layout changes than other
applications. So lets try to find the solution that preserves the
kernel's ability to further optimize the VM layout, while meeting Wine's
desire to get a simple VM layout that is not mapped in the first 1 GB or
so.

	Ingo

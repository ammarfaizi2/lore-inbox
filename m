Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbVLPSpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVLPSpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVLPSpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:45:32 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:9897 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932361AbVLPSpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:45:32 -0500
Message-Id: <200512161842.jBGIgjZG003433@laptop11.inf.utfsm.cl>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks 
In-Reply-To: Message from "linux-os \(Dick Johnson\)" <linux-os@analogic.com> 
   of "Fri, 16 Dec 2005 09:39:56 CDT." <Pine.LNX.4.61.0512160927390.30350@chaos.analogic.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Fri, 16 Dec 2005 15:42:45 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 16 Dec 2005 15:42:58 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os \(Dick Johnson\) <linux-os@analogic.com> wrote:

[...]

> Throughout the past two years of 4k stack-wars, I never heard why
> such a small stack was needed (not wanted, needed). It seems that
> everybody "knows" that smaller is better and most everybody thinks
> that one page in ix86 land is "optimum". However I don't think
> anybody ever even tried to analyze what was better from a technical
> perspective. Instead it's been analyzed as religious dogma, i.e.,
> keep the stack small, it will prevent idiots from doing bad things.

OK, so here goes again...

The kernel stack has to be contiguous in /physical/ memory. Keep the stack
/one/ page, that way you can always get a new stack when needed (== each
fork(2) or clone(2)). If the stack is 2 (or more) pages, you'll have to
find (or create) a multi-page free area, and (fragmentation being what it
is, and Linux routinely running for months at a time) you are in a whole
new world of pain.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

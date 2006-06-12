Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWFLL4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWFLL4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbWFLL4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:56:13 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:204 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750998AbWFLL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:56:13 -0400
Date: Mon, 12 Jun 2006 14:56:11 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Ingo Molnar <mingo@elte.hu>
cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
In-Reply-To: <20060612113637.GA14136@elte.hu>
Message-ID: <Pine.LNX.4.58.0606121446130.7129@sbz-30.cs.Helsinki.FI>
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
 <20060611112156.8641.94787.stgit@localhost.localdomain>
 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI> <20060612105345.GA8418@elte.hu>
 <Pine.LNX.4.58.0606121404080.7129@sbz-30.cs.Helsinki.FI> <20060612113637.GA14136@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Ingo Molnar wrote:
> but "supporting existing kernel coding style as-is" is not a must-have 
> criterium for inclusion. While preserving semantics is strongly 
> encouraged of course, a patch can change semantics (or can introduce 
> restrictions) as long as it's common-sense or there is no other way out. 
> The question is benefit vs. disadvantage, not a rigid "does it change 
> semantics" rule.

Agreed.  I wasn't talking about general principles though but about the 
current kmemleak annotations, which I still find lacking as-is.

On Mon, 12 Jun 2006, Ingo Molnar wrote:
> > I found at least two unacceptable false positive classes:
> > 
> >   - arch/i386/kernel/setup.c:
> >     False positive because res pointer is stored in a global instance of
> >     struct resource.
> 
> there's no good way around this one but to annotate it in one way or 
> another.

Scanning bss and data sections is too expensive, I guess.  I would prefer 
we create a separate section for gc roots but what you're suggesting is 
ok as well.
 
On Mon, 12 Jun 2006, Ingo Molnar wrote:
> >   - drivers/base/platform.c and fs/ext3/dir.c:
> >     False positive because we allocate memory for struct + some extra
> >     stuff.
> > 
> > At least the latter can be fixed as outlined by Catalin in another 
> > mail.
> 
> yes.

Indeed and should be fixed before inclusion.

				Pekka

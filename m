Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWFMH5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWFMH5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFMH5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:57:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:45964 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750723AbWFMH5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:57:42 -0400
Date: Tue, 13 Jun 2006 10:57:38 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Catalin Marinas <catalin.marinas@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
In-Reply-To: <b0943d9e0606122359q6ffabdbdqada9a6c79642cf2a@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0606131052400.15861@sbz-30.cs.Helsinki.FI>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> 
 <20060611112156.8641.94787.stgit@localhost.localdomain> 
 <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> 
 <b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com> 
 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>  <20060612105345.GA8418@elte.hu>
  <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com> 
 <20060612192227.GA5497@elte.hu>  <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
 <b0943d9e0606122359q6ffabdbdqada9a6c79642cf2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Tue, 13 Jun 2006, Catalin Marinas wrote:
> The gc roots are the data and bss sections (and maybe task kernel
> stacks) and all the slab-allocated blocks are scanned if a link to
> them is found from the roots (and all of them are usually scanned). If
> no link is found, they would be reported as memory leaks (and not
> scanned). You can't really avoid the scanning of allocated blocks
> since they may contain pointers to other blocks.

I am not sure you're agreeing or disagreeing :-).  As far as I understood, 
Ingo is worried about:

	struct s { /* some fields */; char *buf; };

	struct s *p = kmalloc(sizeof(struct s) + BUF_SIZE);
	p->buf = p + sizeof(struct s);

Which could lead to false negative due to p->buf pointing to p.  However, 
for us to even _find_ p->buf, we would need an incoming pointer _to_ p 
which makes me think this is not a problem in practice.  Hmm?

					Pekka

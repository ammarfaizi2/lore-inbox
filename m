Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUFSHp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUFSHp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 03:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbUFSHp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 03:45:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61674 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263826AbUFSHp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 03:45:27 -0400
Date: Sat, 19 Jun 2004 09:46:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] flexible-mmap-2.6.7-D5
Message-ID: <20040619074612.GB12020@elte.hu>
References: <20040618213814.GA589@elte.hu> <20040618231631.GO1863@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618231631.GO1863@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> > to a more flexible top-down mmap() method:
> > 
> >   0x08000000 ... binary image
> >   0x08xxxxxx ... brk area, grows upwards
> >   0xbfxxxxxx ... _end_ of all mmaps, new mmaps go below old ones
> >   0xbfyyyyyy ... stack
> 
> It may be useful to move STACK_TOP to 0x8040000 give the stack more
> head room and fit small statically-linked executables into one
> pagetable page. Otherwise the stack has very little headroom after the
> first mmap().

the patch already takes care of this via two mechanisms:

- the top of the mmaps is moved down by the expected maximum size of the
  stack (the stack rlimit).

- we maintain a minimum 128 MB 'gap' between stack top and mmap top. 

moving it to 0x08040000 is asking for trouble, there are people who need
1GB stacks (dont ask why). This approach has been in production use for
~2 years and it works fine for a wide range of applications and VM
needs.

	Ingo

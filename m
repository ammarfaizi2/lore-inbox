Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbUCJLdu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUCJLdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:33:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17285 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262147AbUCJLdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:33:47 -0500
Date: Wed, 10 Mar 2004 12:35:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040310113501.GA1112@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random> <20040309153620.GA9012@elte.hu> <20040309163345.GK8193@dualathlon.random> <20040309195752.GA16519@elte.hu> <20040309202744.GS8193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309202744.GS8193@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> the quality of such objrmap patch is still better than rmap. The DoS
> thing is doable with vmtruncate too in any kernel out there.

objrmap for now has a serious problem: test-mmap3.c locked up my box (i
couldnt switch text consoles for 30 minutes when i turned the box off).

I'm sure you'll fix it and i'm looking forward seeing it.  However, i'd
like to see the full fix instead of a promise to have this fixed
sometime the future.  There are valid application workloads that trigger
_worse_ vma patterns than test-mmap3.c does (UML being one such thing,
Oracle with indirect buffer-cache another - i'm sure there are other
apps too.).  Calling these applications 'exploits' doesnt help in
getting this thing fixed.  There's no problem with keeping this patchset
separate until it's regression-free.

> merging objrmap is the first step. Any other effort happens on top of
> it.

i'd like to see that effort combined with this code, and the full
picture.  Since this 'DoS property' is created by the current concept of
the patch, it's not a 'bug' that is easily fixed so we must not (and
cannot) sign up for it blindly, without seeing the full impact.  But
yes, it might be fixable.  Anyway - the 2.6 kernel is a stable tree and
i'm sure you know that avoiding regression is more important than
anything else.

	Ingo

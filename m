Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVBFOIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVBFOIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVBFOIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:08:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5029 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261249AbVBFOIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:08:12 -0500
Date: Sun, 6 Feb 2005 15:08:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206140802.GA6323@elte.hu>
References: <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org> <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu> <20050206134640.GB30476@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206134640.GB30476@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> wrote:

> > RWE. But if it triggers it shows up immediately so it's not like you
> > have no sign that something wrong is going on. Only grub-install
> > triggers it and no boot/install kernel i know of defaults to
> > PAE-enabled, that's what caused grub-install being used in an NX
> > scenario so infrequently.)
> > 
> > anyway, this particular flamewar might have made more sense last Summer.
> 
> Last summer nobody did change the 32bit ABI on x86-64.
> 
> I only started it because the bug reports are appearing now and it's
> clear now that we have a problem. 

the vanilla 2.6.10 x64 kernel, using 32-bit fedora userland boots fine
here, and gives a noexec stack:

 $ ./test-stack
 Segmentation fault
 $
 $ uname -a
 Linux saturn 2.6.10 #1 Sun Feb 6 15:52:44 CET 2005 x86_64 x86_64 x86_64 GNU/Linux
 $
 $ readelf -l test-stack | grep STA
   GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4

	Ingo

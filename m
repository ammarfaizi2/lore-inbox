Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbUCOJSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUCOJSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 04:18:47 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16525 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262459AbUCOJSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 04:18:43 -0500
Date: Mon, 15 Mar 2004 10:19:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
Message-ID: <20040315091843.GA21587@elte.hu>
References: <20040310233140.3ce99610.akpm@osdl.org> <16465.3163.999977.302378@notabene.cse.unsw.edu.au> <20040311172244.3ae0587f.akpm@osdl.org> <16465.20264.563965.518274@notabene.cse.unsw.edu.au> <20040311235009.212d69f2.akpm@osdl.org> <16466.57738.590102.717396@notabene.cse.unsw.edu.au> <16469.2797.130561.885788@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16469.2797.130561.885788@notabene.cse.unsw.edu.au>
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


* Neil Brown <neilb@cse.unsw.edu.au> wrote:

> And it turns out it was spot on. Applying 4g-2.6.0-test2-mm2-A5.patch
> (on top of preceding -mm1 patches) causes my server not to boot.

hm. Since your .config boots on akpm's box, this is some BIOS dependency
creating an early-boot problem i fear. Debugging such bugs is hard. One 
way would be via the PC speaker:

	movb $0x3,%al; outb %al,$0x61

this will cause a continuous beep on a typical PC - it works in 16-bit
code too, doesnt have any memory-model assumptions, etc.

the first place to put this would be startup_32 - do we get to this
point at all? (check CONFIG_4G first, to make sure the beep triggers.) 
If it beeps, then move it down until you find the place that crashes.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUFDQIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUFDQIa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUFDQI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:08:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:1700 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263975AbUFDQFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:05:20 -0400
Date: Fri, 4 Jun 2004 18:06:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Message-ID: <20040604160628.GA32375@elte.hu>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> I think we should just look at the executable itself, not whether it
> is suid. If the executable says it is "NX-approved", then it's
> NX-approved.  End of story - just try to make sure that as many
> executables as possible get compiled with the newer compiler suite
> that enables it.

right now the 'x' bit in the PT_GNU_STACK ELF program header has the
narrow meaning of specifcing the stack's executability. How should we
handle the brk area's executability? A good portion of recent attacks
came over heap overflows.

we could use the following 3 values:

 PT_GNU_STACK not present: legacy app, stack and heap executable
 PT_GNU_STACK present but !X: heap non-executable, stack executable
 PT_GNU_STACK present and X: both heap and stack are executable.

this method is what is used in Fedora and it works pretty well.

(in fact Fedora also does VM-layout changes to get more brk/mmap space
on x86 and to put executable code close to each other - this too is
turned off if PT_GNU_STACK is not present.)

	Ingo

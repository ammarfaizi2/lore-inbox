Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVBVIE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVBVIE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 03:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVBVIE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 03:04:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37015 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262243AbVBVIE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 03:04:56 -0500
Date: Tue, 22 Feb 2005 09:04:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
Cc: Martin =?iso-8859-1?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: memory management weirdness
Message-ID: <20050222080431.GB778@elte.hu>
References: <4219E62D.7000009@ribosome.natur.cuni.cz> <m14qg5mq5v.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qg5mq5v.fsf@muc.de>
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


* Andi Kleen <ak@muc.de> wrote:

> >   Although I've not re-tested this today again, it used to help a bit to specify
> > mem=3548M to decrease memory used by linux (tested with AGP card plugged in, when
> > bios reported 3556MB RAM only).
> >
> >   I found that removing the AGP based videoc card and using an old PCI based
> > video card results in bios detecting 4072MB of RAM. But still, the machine was
> > slow. I've tried to "cat >| /proc/mtrr" to alter the memory settings, but the
> > result was only a partial speedup.
> >
> >   I'm not sure how to convince linux kernel to run fast again.
> 
> It's most likely a MTRR problem. Play more with them.

in particular, try to create two small tables in the same format: one
showing the e820 memory map as reported in your kernel log, and one
showing the mtrr areas. If there is any e820 area that is not write-back
cached via the mtrr mappings then that's the problem. You can also use
"mem=exactmap,..." to fix up the memory map that the BIOS provides to
Linux. Slowdowns are very often such MTRR problems. (perhaps the kernel
should report RAM areas that are not covered by MTRR write-back?)

	Ingo

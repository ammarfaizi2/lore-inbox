Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVDKQjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDKQjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVDKQfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:35:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:13512 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261842AbVDKQeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:34:24 -0400
Date: Mon, 11 Apr 2005 18:33:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@engr.sgi.com>, pasky@ucw.cz, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: [rfc] git: combo-blobs
Message-ID: <20050411163358.GA9696@elte.hu>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050411113523.GA19256@elte.hu> <20050411074552.4e2e656b.pj@engr.sgi.com> <20050411151204.GA5562@elte.hu> <Pine.LNX.4.58.0504110826140.1267@ppc970.osdl.org> <20050411153905.GA7284@elte.hu> <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504110852260.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> >	 Also, with a 'replicate the full object on every 8th commit' 
> > rule the risk would be somewhat mitigated as well.
> 
> ..but not the complexity.
> 
> The fact is, I want to trust this thing. Dammit, one reason I like GIT 
> is that I can mentally visualize the whole damn tree, and each step is 
> so _simple_. That's extra important when the object database itself is 
> so inscrutable - unlike CVS or SCCS or formats like that, it's damn 
> hard to visualize from looking at a directory listing.

ok. Meanwhile i found another counter-argument: the average committed 
file size is 36K, which with gzip -9 would compress down to roughly 8K, 
with the commit message being another block. That's 2+1 blocks used per 
commit, while with deltas one could at most cut this down to 1+1+1 
blocks - just as much space! So we would be almost even with the more 
complex delta approach, just by increasing the default compression ratio 
from 6 to 9. (but even with the default we are not that bad.)

case closed i guess. (The network bandwith issue can/could indeed be 
solved independently, without any impact to the fundamentals, as you 
suggested.)

	Ingo

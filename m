Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUK0CCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUK0CCt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262983AbUKZTiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:38:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:55234 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262379AbUKZT0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:02 -0500
Date: Fri, 26 Nov 2004 02:14:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm3-V0.7.31-3 memory leak (was Re: Debugging a memory leak
Message-ID: <20041126011404.GA4189@elte.hu>
References: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu> <20041123153858.6df49fde.akpm@osdl.org> <200411250842.iAP8gC6U011822@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411250842.iAP8gC6U011822@turing-police.cc.vt.edu>
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


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> On Tue, 23 Nov 2004 15:38:58 PST, Andrew Morton said:
> > Valdis.Kletnieks@vt.edu wrote:
> > >
> > > Any advice how to shoot this one?
> > 
> > Manfred's slab leak detector:
> 
> Ahh, many thanks - that helped quite a bit.  I tracked down the
> problem - it was in Ingo's VP patch.
> 
> sys_ioperm() would allocate an 8K bitmap and save it in
> ->io_bitmap_ptr. Then when we hit exit_thread(), Ingo's code would
> zero the pointer and *then* pass the freshly-zero'ed pointer to
> kfree() - which of course did nothing particularly interesting.  My
> fix was to save a copy of the pointer to pass to kfree.  Am seeing no
> more leaks.

ah ... good catch - patch applied.

	Ingo

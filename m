Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263286AbVFXTy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263286AbVFXTy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 15:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVFXTyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 15:54:09 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49819 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263385AbVFXTxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 15:53:00 -0400
Date: Fri, 24 Jun 2005 21:52:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
Message-ID: <20050624195248.GA9663@elte.hu>
References: <20050621130344.05d62275.akpm@osdl.org> <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu> <320710000.1119632967@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <320710000.1119632967@flay>
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


* Martin J. Bligh <mbligh@mbligh.org> wrote:

> > -	/*
> > -	 * In the NUMA case we dont use the TSC as they are not
> > -	 * synchronized across all CPUs.
> > -	 */
> > -#ifndef CONFIG_NUMA
> > -	if (!use_tsc)
> > -#endif
> > +	if (!cpu_has_tsc)
> >  		/* no locking but a rare wrong value is not a big deal */
> >  		return jiffies_64 * (1000000000 / HZ);
> 
> Humpf. That does look dangerous on a NUMA-Q. The TSCs aren't synced, 
> and we can't use them .... have to use PIT, whether the CPUs have TSC 
> or not.

is the only problem the unsyncedness? That should be fine as far as the 
scheduler is concerned. (we compensate for per-CPU drifts)

	Ingo

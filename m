Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTJ1LFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 06:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTJ1LFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 06:05:51 -0500
Received: from gprs196-218.eurotel.cz ([160.218.196.218]:28547 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263979AbTJ1LFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 06:05:45 -0500
Date: Tue, 28 Oct 2003 12:04:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Autoregulate vm swappiness cleanup
Message-ID: <20031028110443.GA1792@elf.ucw.cz>
References: <200310232337.50538.kernel@kolivas.org> <8720000.1066920153@[10.10.2.4]> <200310240103.19336.kernel@kolivas.org> <200310251658.23070.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310251658.23070.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It seems that you don't need si_swapinfo here, do you? i.freeram,
> > > i.bufferram, and i.totalram all come from meminfo, as far as I can
> > > see? Maybe I'm missing a bit ...
> >
> > Well I did do it a while ago and it seems I got carried away adding and
> > subtracting info indeed. :-) Here's a simpler patch that does the same
> > thing.
> 
> The off-list enthusiasm has been rather strong so here is a patch done the 
> right way (tm). There is no need for the check of totalram being zero (the 
> original version of this patch modified the swappiness every tick which was 
> wasteful and had a divide by zero on init). Adjusting vm_swappiness only when 
> there is pressure to swap means totalram shouldn't be ever be zero. The 
> sysctl is made read only since writing to it would be ignored now.

I believe swappiness == 100 was "I want max throughput, I don't care
about latency going through roof", while swappiness == 0 was "I don't
want you to swap too much, behave reasonably".

As you don't know if user cares about latency or not, I don't see how
you can autotune this.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

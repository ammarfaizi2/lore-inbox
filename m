Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbUKVNBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbUKVNBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUKVNBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:01:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58026 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262067AbUKVNAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:00:36 -0500
Date: Mon, 22 Nov 2004 06:35:48 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Ross <chris@tebibyte.org>
Cc: Andrew Morton <akpm@osdl.org>, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041122083548.GA26131@logos.cnet>
References: <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org> <41A0E60C.605@tebibyte.org> <41A1D850.6090706@tebibyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A1D850.6090706@tebibyte.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 01:15:12PM +0100, Chris Ross wrote:
> Hi Andrew,
> 
> Chris Ross escreveu:
> > Andrew Morton escreveu:
> >> Please ignore the previous patch and try the below.
> >
> > I still get OOM kills with this (well one, anyway). It does seem harder
> > to trigger though.
> 
> Turns out it's not that hard. Sorry for the slight delay, I've been away 
> a few days.
> 
> root@sleepy chris # grep Killed /var/log/messages
> Nov 21 22:24:22 sleepy Out of Memory: Killed process 6800 (qmgr).
> Nov 21 22:24:32 sleepy Out of Memory: Killed process 6799 (pickup).
> Nov 21 22:24:57 sleepy Out of Memory: Killed process 6472 (distccd).
> Nov 21 22:25:00 sleepy Out of Memory: Killed process 6473 (distccd).
> Nov 21 22:25:00 sleepy Out of Memory: Killed process 6582 (distccd).
> Nov 21 22:25:00 sleepy Out of Memory: Killed process 6686 (distccd).
> Nov 21 22:25:00 sleepy Out of Memory: Killed process 6687 (ntpd).
> 
> If you want to seem the actual oom messages just ask.
> 
> This is with 2.6.10-rc2-mm1 + your patch whilst doing an "emerge sync" 
> which isn't ridiculously memory hungry and shouldn't result in oom kills.
> 
> Informally I felt I had better results from Marcelo's patch, though I 
> should test both under the same conditions before I say that...

Chris, 

The kill-from-kswapd approach on top of recent -mm which includes 
"ignore referenced information on zero priority" should be quite 
reliable. Would be nice if you could try that. 

The current scheme is broken yes, the main problem being the all_unreclaimable
logic which conflicts with OOM detection - I (we) were hoping 
"ignore-referenced-information-on-zero-priority" would be enough for 99% of 
cases, but it doesnt seem so.

Either way killing from kswapd or from task context all_unreclaimable logic 
is conflitant with OOM detection.

But we are going the right way :)

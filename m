Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWFDC37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWFDC37 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWFDC37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:29:59 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:54200 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751461AbWFDC36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:29:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rSEPfA8abjjRuMfA/4rM9Eiz0RIiGW4a4qMD1mt19GNtzlmDal0WdHNQ3rnM0AyZRrUIhUGJC8wzKIQiS0otFsB4wPNkFPeBL/TA49EyCAHDn8OPd8lfXfHOVYutfEfT9dyGyC3W5tzaYq4oetu/ymQes+XELl3nt92PvJAGz2Q=
Message-ID: <986ed62e0606031929g41ad18fbrb1788c26da86287f@mail.gmail.com>
Date: Sat, 3 Jun 2006 19:29:58 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <986ed62e0606031410h48efd8b7i3a89e1c7ba1cd778@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
	 <20060602142009.GA10236@elte.hu>
	 <986ed62e0606021101t6701d095ycd29c91885aaeec9@mail.gmail.com>
	 <20060602205332.GA5022@elte.hu>
	 <986ed62e0606021533n4c8954eeifd71f97611a4c7f@mail.gmail.com>
	 <20060603071301.GB19257@elte.hu> <20060603144121.GA3701@elte.hu>
	 <986ed62e0606031410h48efd8b7i3a89e1c7ba1cd778@mail.gmail.com>
X-Google-Sender-Auth: c19cb4db97c53684
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/06, Barry K. Nathan <barryn@pobox.com> wrote:
> I was already doing OPTIMIZE_FOR_SIZE. I didn't think of disabling
> FORCED_INLINING, thanks for reminding me of that. I managed to trim
> the kernel in other ways.

Hmm... disabling FORCED_INLINING didn't make much if any difference.

> > also, the latest combo patch:
> >
> >   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm2.patch
> >
> > should have the floppy bug(s) fixed.
>
> I'll try that later today (and I'll also provide the
> /proc/latency_trace to help figure out the warning). In the meantime,
[snip]

Yes, the latest combo patch works. It still gives the warning, too
(copied here since it looks slightly different with the latency trace
patch added):

[  197.343620] (            idle-0    |#0): new 120978036 us user-latency.
[  197.343807] stopped custom tracer.
[  197.343948] BUG: warning at kernel/lockdep.c:1856/trace_hardirqs_on()
[  197.345928]  [<c010329b>] show_trace_log_lvl+0x5b/0x105
[  197.346359]  [<c0103896>] show_trace+0x1b/0x20
[  197.346759]  [<c01038ed>] dump_stack+0x1f/0x24
[  197.347159]  [<c012efa2>] trace_hardirqs_on+0xfb/0x185
[  197.348873]  [<c029b009>] _spin_unlock_irq+0x24/0x2d
[  197.350620]  [<e09034e8>] do_tx_done+0x171/0x179 [ns83820]
[  197.350895]  [<e090445c>] ns83820_irq+0x149/0x20b [ns83820]
[  197.351166]  [<c013b4b8>] handle_IRQ_event+0x1d/0x52
[  197.353216]  [<c013c6c2>] handle_level_irq+0x97/0xe1
[  197.355157]  [<c01048c3>] do_IRQ+0x8b/0xac
[  197.355612]  [<c0102d9d>] common_interrupt+0x25/0x2c

I've posted the /proc/latency_trace here:
http://members.cox.net/barrykn/linux/trace/latency_trace.bz2

It turns out that I was *way* off on the size in my last mail. It's
actually close to 9MB decompressed, 370K bz2-compressed.
-- 
-Barry K. Nathan <barryn@pobox.com>

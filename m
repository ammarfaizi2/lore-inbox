Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbVJFUH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVJFUH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVJFUHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:07:55 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:8564 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751341AbVJFUHy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:07:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RnUVryhjIqPgmlDN6DPu2SkaZejFu8DSINL/X8V1attLP9XrMPzQ7tnCFbeUyDKUmraRhGITEwFHNNNm34sSnrDlGx8Eus2DDt3ADyDV/SUDcuvqhvXU64veiJpBVCn23yfSuDemcrlCTMbhgCqzBhuGjmyO/o7pELJ8j5HFGiE=
Message-ID: <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
Date: Thu, 6 Oct 2005 13:07:52 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051006195242.GA15448@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> >    I am still getting a few xruns even after raising Jack's priority
> > level to 80. I am wondering whether it's fair to report these when I
> > have CONFIG_DEBUG_PREEMPT set?
>
> >   4559  78     38 [IRQ 58]
>
> >   58:     257570   IO-APIC-level  hdsp
>
> IRQ 58 is your audio interrupt, right? You should raise that one to prio
> 80 too. (via chrt)
>
> > Since my NIC is getting a higher priority than both my sound card and
> > my 1394 audio drives (IRQ217 vs. IRQ58/IRQ66) I assume that network
> > activity might possibly sometimes cause a problem? Or is this not
> > true?
>
> yeah, that could be the case.
>
>         Ingo
>

Thanks Ingo,
   I've set the HDSP priority to 80 using chrt. I'll continue to test away.

lightning ~ # ps -Leo pid,pri,rtprio,cmd | grep 58
 4559  78     38 [IRQ 58]
 8723  22      - grep 58
lightning ~ #  chrt -p 4559
pid 4559's current scheduling policy: SCHED_FIFO
pid 4559's current scheduling priority: 38
lightning ~ # chrt -p 80 4559
lightning ~ # chrt -p 4559
pid 4559's current scheduling policy: SCHED_RR
pid 4559's current scheduling priority: 80
lightning ~ #

   Can you suggest how I might be able to do this at boot time? Is
seems that the info is there but it requires figuring out the process
ID in a script and then running chrt in that script? Or is there a
simple place to configure how much priority I want to give a specific
IRQ?

   Anyway, thanks for all the help. I'll continue on. Probably I won't
see too many xruns with this set like this.

cheers,
Mark

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268877AbTBZSgg>; Wed, 26 Feb 2003 13:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268879AbTBZSgg>; Wed, 26 Feb 2003 13:36:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:59091 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268877AbTBZSgf>;
	Wed, 26 Feb 2003 13:36:35 -0500
Date: Wed, 26 Feb 2003 10:47:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davej@codemonkey.org.uk, schlicht@uni-mannheim.de, torvalds@transmeta.com,
       hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-Id: <20030226104723.76df4b18.akpm@digeo.com>
In-Reply-To: <1046266771.8948.1.camel@irongate.swansea.linux.org.uk>
References: <200302251908.55097.schlicht@uni-mannheim.de>
	<20030226103742.GA29250@suse.de>
	<20030226015409.78e8e1fb.akpm@digeo.com>
	<20030226111905.GA32415@suse.de>
	<20030226022819.44e1873a.akpm@digeo.com>
	<1046266771.8948.1.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 18:46:45.0314 (UTC) FILETIME=[69358220:01C2DDC7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Wed, 2003-02-26 at 10:28, Andrew Morton wrote:
> > Dave Jones <davej@codemonkey.org.uk> wrote:
> > >
> > > btw, (unrelated) shouldn't smp_call_function be doing magick checks
> > > with cpu_online() ?
> > 
> > Looks OK?  It sprays the IPI out to all the other CPUs in cpu_online_map,
> > and waits for num_online_cpus()-1 CPUs to answer.
> 
> You cannot do that by counting without a lot of care. IPI messages do not have
> guaranteed "once only" semantics. On an error a resend can and has been observed
> to cause a reissue of an IPI on PII/PIII setups

If that resend results in delivery of an actual extra interrupt, the
resent-to CPU can start playing with stuff which used to be on the sender's
stack and the box goes splat.

Didn't sct have a fix for that?

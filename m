Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVDBXqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDBXqD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDBXqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:46:03 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64708 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261366AbVDBXpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:45:50 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.43-00
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Gene Heskett <gene.heskett@verizon.net>,
       LKML <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20050402203550.GB16230@elte.hu>
References: <20050325145908.GA7146@elte.hu>
	 <200504011419.20964.gene.heskett@verizon.net> <424D9F6A.8080407@cybsft.com>
	 <200504011834.22600.gene.heskett@verizon.net>
	 <20050402051254.GA23786@elte.hu>
	 <1112470675.27149.14.camel@localhost.localdomain>
	 <1112472372.27149.23.camel@localhost.localdomain>
	 <20050402203550.GB16230@elte.hu>
Content-Type: multipart/mixed; boundary="=-seFKkFu8eElPj5FkxCVy"
Date: Sat, 02 Apr 2005 18:45:46 -0500
Message-Id: <1112485548.28826.91.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-seFKkFu8eElPj5FkxCVy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-04-02 at 22:35 +0200, Ingo Molnar wrote:
> > For kicks I ran this on 2.6.11-rc2-RT-V0.7.36-02 (I still had it as a 
> > Grub option), and the system just locked up hard.  I just was curious 
> > if this was from a different change. But at least in the latest it 
> > shows output, and not just a hard lockup.
> > 
> > Oh, the bug report was running kernel 2.6.12-rc1-RT-V0.7.43-06.
> 
> ok, so it's not the recent NFS changes.

Here's an interesting trace I got today.  It looks either the emu10k1 or
USB irq handler left IRQ 10 disabled.  This isn't a tracer bug because
you can clearly see this leads to an xrun.  Since I've been hacking the
emu10k1 driver quite a bit, I suspect this is the problem.

This trace also shows that my trigger callback for the emu10k1
multichannel device needs optimizing; it takes 300 usecs to stop all 16
voices, not acceptable for an ALSA irq handler which uses SA_INTERRUPT.
I think I can improve this significantly by reordering the register
settings and eliminating some function call overhead.

Lee

--=-seFKkFu8eElPj5FkxCVy
Content-Disposition: attachment; filename=latency_trace.bz2
Content-Type: application/x-bzip; name=latency_trace.bz2
Content-Transfer-Encoding: base64

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


--=-seFKkFu8eElPj5FkxCVy--


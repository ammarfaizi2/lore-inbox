Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWGDPTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWGDPTm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWGDPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:19:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54704 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750815AbWGDPTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:19:41 -0400
Date: Tue, 4 Jul 2006 17:15:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [BUG] scsi/io-elevator held lock freed.
Message-ID: <20060704151504.GA10779@elte.hu>
References: <1152024854.29262.5.camel@c-67-180-134-207.hsd1.ca.comcast.net> <1152026010.3109.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152026010.3109.66.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Tue, 2006-07-04 at 07:54 -0700, Daniel Walker wrote:
> > I got this during boot. I booted the same kernel several times, and only
> > saw it once. The kernel was 2.6.17-mm5 .
> > 
> > Daniel
> > 
> > 
> > =========================
> > [ BUG: held lock freed! ]
> > -------------------------
> > swapper/1 is freeing memory f73a8580-f73a867f, with a lock still held there!
> > 2 locks held by swapper/1:
> >  #0:  (&shost->scan_mutex){--..}, at: [<c0419098>] mutex_lock+0x8/0x10
> >  #1:  (&eq->sysfs_lock){--..}, at: [<c0419098>] mutex_lock+0x8/0x10
> 
> blargh.. it'd be more useful if lockdep actually printed which lock it 
> is that it thinks is about to get freed.....

i think it's eq->sysfs_lock that is being freed here.

> this patch ought to make it do that; could you at least add this to 
> your kernel?
> 
> Ingo, is this the right approach?

yeah, that's OK.

	Ingo

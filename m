Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265243AbUE0VDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUE0VDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbUE0VDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:03:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11701 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265243AbUE0VDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:03:36 -0400
Date: Thu, 27 May 2004 23:04:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Takao Indoh <indou.takao@soft.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
Message-ID: <20040527210447.GA2029@elte.hu>
References: <1CC443CDA50AF2indou.takao@soft.fujitsu.com> <1FC443E79D3948indou.takao@soft.fujitsu.com> <20040527135134.GC15356@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527135134.GC15356@infradead.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> > +/******************************** Disk dump ***********************************/
> > +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
> > +#undef  add_timer
> > +#define add_timer       diskdump_add_timer
> > +#undef  del_timer_sync
> > +#define del_timer_sync  diskdump_del_timer
> > +#undef  del_timer
> > +#define del_timer       diskdump_del_timer
> > +#undef  mod_timer
> > +#define mod_timer       diskdump_mod_timer
> > +
> > +#define tasklet_schedule        diskdump_tasklet_schedule
> > +#endif
> 
> Yikes.  No way in hell we'll place code like this in drivers.  This
> needs to be handled in common code.

yeah, this is arguably the biggest (and i think only) conceptual item
that needs to be solved before this can be integrated.

The goal of these defines is to provide a separate (and polling based)
timer mechanism that is completely separate from the normal kernel's
state.

it would also be easier to enable diskdump in a driver if this was
handled in add_timer()/del_timer()/mod_timer()/tasklet_schedule().

	Ingo

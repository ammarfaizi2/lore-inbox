Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265535AbSJSDTa>; Fri, 18 Oct 2002 23:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265542AbSJSDTa>; Fri, 18 Oct 2002 23:19:30 -0400
Received: from fmr01.intel.com ([192.55.52.18]:31996 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265535AbSJSDT3>;
	Fri, 18 Oct 2002 23:19:29 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC807@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au
Subject: RE: [PATCH] Priority-based real-time futexes [Try two, stupid Out
	look wrapped it]
Date: Fri, 18 Oct 2002 20:25:28 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I have completed the priority-based futex support; now the code
> > behaves well completely, as futex_fd and poll() work as before, but
> > priority based. So, tasks that are sleeping on a futex get 
> 
> Very useful for real-time tasks...
> 
> I did not think NPTL did real-time threads, though?

Nope so far, as per Ulrich's word, this was one of the things that
held it out; same thing for NGPT. With this I can implement "more"
true real-time in NGPT.
 
> >  - I don't remember if it is safe to call kmalloc with 
> GFP_KERNEL from
> >    inside an spinlock. Common sense says NO to me - just in case, in
> >    the areas where I need it, I use GFP_ATOMIC. Any confirmations?
> 
> No, it is not safe as then you can sleep and consequently deadlock.
> 
> GFP_ATOMIC is the fix but be weary of how much memory you allocate and
> make sure you always check for failure and have some course of action
> there.

Yep - error paths should be ok, but your are right, I don't want to
waste atomic memory. Heavily locked applications might exhaust it.
I'll check that out.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]


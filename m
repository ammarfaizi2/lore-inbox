Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWELLNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWELLNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWELLNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:13:14 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36840 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751215AbWELLNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:13:14 -0400
Date: Fri, 12 May 2006 13:12:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
Subject: Re: [RFC][PATCH RT 1/2] futex_requeue-optimize
Message-ID: <20060512111256.GA27481@elte.hu>
References: <20060510112701.7ea3a749@frecb000686> <20060511091541.05160b2c.akpm@osdl.org> <20060512063220.GA630@elte.hu> <1147421427.3969.60.camel@frecb000686> <1147432419.3969.70.camel@frecb000686>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1147432419.3969.70.camel@frecb000686>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.6 required=5.9 tests=AWL,SUBJ_HAS_UNIQ_ID autolearn=no SpamAssassin version=3.0.3
	1.1 SUBJ_HAS_UNIQ_ID       Subject contains a unique ID
	-0.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sébastien Dugué <sebastien.dugue@bull.net> wrote:

> On Fri, 2006-05-12 at 10:10 +0200, Sébastien Dugué wrote:
> > On Fri, 2006-05-12 at 08:32 +0200, Ingo Molnar wrote:
> > > * Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > Should the futex code be using hlist_heads for that hashtable?
> > > 
> > > yeah. That would save 1K of .data on 32-bit platforms, 2K on 64-bit 
> > > platforms.
> > 
> >   I'll try to look into this.
> > 
> 
>   Well, moving the hash bucket list to an hlist may save a few bytes 
> on .data, but all the insertions are done at the tail on this list 
> which would not be easily done using hlists.
> 
>   Any thoughts?

just queue to the head. This is a hash-list, ordering has only 
performance effects.

	Ingo

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbUCNEKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 23:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbUCNEKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 23:10:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:12737 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263281AbUCNEKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 23:10:13 -0500
Date: Sat, 13 Mar 2004 20:10:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC] kref, a tiny, sane, reference count object
Message-Id: <20040313201017.775ab48b.akpm@osdl.org>
In-Reply-To: <4053D1EB.1070108@cyberone.com.au>
References: <20040313082003.GA13084@kroah.com>
	<20040313163451.3c841ac2.akpm@osdl.org>
	<4053D1EB.1070108@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> 
> Andrew Morton wrote:
> 
> >Greg KH <greg@kroah.com> wrote:
> >
> >>For all of those people, this patch is for you.
> >>
> >
> >It does rather neatly capture a common idiom.
> >
> 
> But as Andi said - look at all the crap involved when:
> 
> atomic_inc();
> if (atomic_dec_and_test())
>     release();
> Also neatly captures that idiom.

Well it does more than that, such as trapping the hard-to-diagnose bug
of grabbing a refcount against a zero-ref object.

> And you get more flexibility by being able to use atomic_set
> directly too.

Do I care about that?  I care more about being able to say "ah, it uses
kref.  I understand that refcounting idiom, I know it's well debugged and I
know that it traps common errors".  That's better than "oh crap, this thing
implements its own refcounting - I need to review it for the usual
errors".



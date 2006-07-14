Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbWGNR7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbWGNR7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422692AbWGNR7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:59:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52429 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422694AbWGNR7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:59:14 -0400
Date: Fri, 14 Jul 2006 10:58:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: rostedt@goodmis.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove volatile from nmi.c
Message-Id: <20060714105841.4490c0e2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	<Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	<Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
	<1152898699.27135.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2006 10:41:58 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 14 Jul 2006, Steven Rostedt wrote:
> > 
> > > 	endflag = 1;
> > > 	smp_wmb();
> > 
> > This was what I originally wrote, and then I saw the set_wmb which made
> > me think that it was the proper way to do things (why else is it
> > there?). So if it shouldn't be used, then we should get rid of it or at
> > least mark it deprecated, otherwise you have people like me thinking
> > that we should use it.
> 
> Yeah, we should probably get rid of it. No need to even mark it 
> deprecated, since nobody uses it anyway. 
> 
> At a minimum, I think we should not document it in the locking 
> documentation, making people incorrectly think it might be a good idea.
> 
> Hmm? Andrew?
> 

It has no callers and can be trivially reimplemented by any out-of-tree
caller, so we should be able to remove it immediately.


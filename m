Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbSLKQs0>; Wed, 11 Dec 2002 11:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbSLKQs0>; Wed, 11 Dec 2002 11:48:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267218AbSLKQsV>;
	Wed, 11 Dec 2002 11:48:21 -0500
Subject: Re: [lkcd-devel] Re: [PATCH] Notifier for significant events on
	i386
From: Stephen Hemminger <shemminger@osdl.org>
To: vamsi@in.ibm.com
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, ak@suse.de, cminyard@mvista.com,
       vamsi_krishna@in.ibm.com
In-Reply-To: <20021211171337.A17600@in.ibm.com>
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net>
	 <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com>
	 <20021211171337.A17600@in.ibm.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1039625764.1649.12.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Dec 2002 08:56:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 03:43, Vamsi Krishna S . wrote:
> On Wed, Dec 11, 2002 at 03:16:39AM -0800, William Lee Irwin III wrote:
> > On Wed, Dec 11, 2002 at 04:51:53PM +0530, Vamsi Krishna S . wrote:
> > > <snip>
> > >
> > > I am considering using a RCU-based list for notifier chains.
> > > Corey has done some work on these lines to add NMI notifier
> > > chain, I think it should be generalised on for all notifiers.
> > 
> > A coherent explanation of how notifier locking is supposed to work
> > would be wonderful to have. I'd like to register notifiers but am
> > pig ignorant of how to lock my structures down to work with it.
> > 
> Unless I am missing something, notifiers have always been racy. 
> No amount of locking you do in individual modules to prevent
> races will help as the notifier chain is walked inside 
> notifier_call_chain() in kernel/sys.c. One would need to
> add some form of locking there (*) so that users of notifier
> chains need not worry about races/locking at all.
> 
> (*) converting the notifier chain to an RCU-based list guarentees
> to modules using the notifier chains that their handlers will
> not be called once the handler is unregistered.
> 
> > Bill
> Vamsi.

There should be a register/unregister interface that uses RCU.  That
makes sense.  This assumes that this is an uncommon thing that happens
at init/load and unload. The notifier callback's better not change
themselves! Especially, since they get called when the system may be in
a unstable state like in a panic or other error handling.

-- 
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab


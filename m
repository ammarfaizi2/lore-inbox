Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267114AbSLKLVM>; Wed, 11 Dec 2002 06:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267116AbSLKLVM>; Wed, 11 Dec 2002 06:21:12 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:25756 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267114AbSLKLVL>;
	Wed, 11 Dec 2002 06:21:11 -0500
Date: Wed, 11 Dec 2002 17:13:37 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>,
       lkcd-devel@lists.sourceforge.net, ak@suse.de, cminyard@mvista.com,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] Notifier for significant events on i386
Message-ID: <20021211171337.A17600@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <1039471369.1055.161.camel@dell_ss3.pdx.osdl.net> <20021211165153.A17546@in.ibm.com> <20021211111639.GJ9882@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021211111639.GJ9882@holomorphy.com>; from wli@holomorphy.com on Wed, Dec 11, 2002 at 03:16:39AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 03:16:39AM -0800, William Lee Irwin III wrote:
> On Wed, Dec 11, 2002 at 04:51:53PM +0530, Vamsi Krishna S . wrote:
> > <snip>
> >
> > I am considering using a RCU-based list for notifier chains.
> > Corey has done some work on these lines to add NMI notifier
> > chain, I think it should be generalised on for all notifiers.
> 
> A coherent explanation of how notifier locking is supposed to work
> would be wonderful to have. I'd like to register notifiers but am
> pig ignorant of how to lock my structures down to work with it.
> 
Unless I am missing something, notifiers have always been racy. 
No amount of locking you do in individual modules to prevent
races will help as the notifier chain is walked inside 
notifier_call_chain() in kernel/sys.c. One would need to
add some form of locking there (*) so that users of notifier
chains need not worry about races/locking at all.

(*) converting the notifier chain to an RCU-based list guarentees
to modules using the notifier chains that their handlers will
not be called once the handler is unregistered.

> Bill
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com

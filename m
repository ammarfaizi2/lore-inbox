Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUJHWui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUJHWui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 18:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUJHWui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 18:50:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55294 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266169AbUJHWuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 18:50:32 -0400
Subject: Re: [ckrm-tech] Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic
	sched_domains
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Erich Focht <efocht@hpce.nec.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net
In-Reply-To: <4166B75A.1020002@watson.ibm.com>
References: <1097110266.4907.187.camel@arrakis>
	 <200410081214.20907.efocht@hpce.nec.com> <41666E90.2000208@yahoo.com.au>
	 <4166B75A.1020002@watson.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097275736.6470.93.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 15:48:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 08:50, Hubertus Franke wrote:
> Nick Piggin wrote:
> > Agreed? You don't need to get fancier than that, do you?
> > 
> > Then how to input the partitions... you could have a sysfs entry that
> > takes the complete partition info in the form:
> > 
> > 0,1,2,3 4,5,6 7,8 ...
> > 
> > Pretty dumb and simple. 
> 
> Agreed, what we are thinking is that the CKRM API can be used for that.
> Each domain is a class build of resources (cpus,mem).
> You use the config interface of CKRM to specify which cpu/mem belongs
> to the class. The underlying controller verifies it.
> 
> For a first approximation, classes that have config constraints 
> specified this way will not be allowed to set shares. In sched_domain
> terms it would mean that if the sched_domain is not balancable with its
> siblings then it forms an exclusive domain. Under the exclusive
> class one can continue with the hierarchy that will allow share settings.
> 
> So from an API issue this certainly looks feasible, maybe even clean.

For anyone who doesn't grok CRKM-speak, as I didn't until some recent
conversations with Hubertus, I think this roughly translates into the
following:

"CKRM & sched_domains should be integrated and include management of
both CPU & memory resources.  We will use the CKRM rcfs filesystem API
to set up both sched_domains and memory allocation constraints.

sched_domains that are marked as exclusive, ie: their parent domains do
not have the SD_LOAD_BALANCE flag set, will not have their computing
power shared outside that domain via CKRM.  This will create 'compute
pools' composed of the exclusive domains in the system.  CKRM will
ensure that 'shares' are correctly handled within exclusive (aka
isolated) domains, and that 'shares' don't include compute resources not
available in the sched_domain in question."

Is that a fairly accurate translation for those not initiated in the
ways of CKRM, Hubertus?

-Matt


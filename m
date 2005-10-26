Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVJZVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVJZVnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVJZVnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:43:55 -0400
Received: from mx1.suse.de ([195.135.220.2]:17622 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964946AbVJZVnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:43:55 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Notifier chains are unsafe
Date: Wed, 26 Oct 2005 23:44:37 +0200
User-Agent: KMail/1.8.2
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@ocs.com.au>,
       dipankar@in.ibm.com,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0510261636580.7186-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0510261636580.7186-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510262344.37982.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 22:40, Alan Stern wrote:
l> On Wed, 26 Oct 2005, Andreas Kleen wrote:
> 
> > > Note that the RCU documentation says RCU critical sections are not
> > > allowed
> > > to sleep.
> > 
> > In this case it would be ok.
> 
> I don't understand.  If it's okay for an RCU critical section to sleep in 
> this case, why wouldn't it be okay always?  What's special here?
> 
> Aren't there requirements about critical sections finishing on the same 
> CPU as they started on?


Like I wrote earlier: as long as the notifier doesn't unregister itself
the critical RCU section for the list walk is only a small part of notifier_call_chain.
It's basically a stable anchor in the list that won't change.

The only change needed would be to make these parts unpreemptable and of course
add a RCU step during unregistration.

-Andi

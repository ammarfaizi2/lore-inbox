Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWFNBYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWFNBYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWFNBYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:24:48 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20122 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932355AbWFNBYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:24:46 -0400
Subject: Re: [Lse-tech] [PATCH 08/11] Task watchers: Register profile as a
	task watcher
From: Matt Helsley <matthltc@us.ibm.com>
To: Chase Venters <chase.venters@clientec.com>
Cc: Andrew Morton <akpm@osdl.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       John T Kohl <jtk@us.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Philippe Elie <phil.el@wanadoo.fr>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       oprofile-list@lists.sourceforge.net
In-Reply-To: <200606131959.47635.chase.venters@clientec.com>
References: <20060613235122.130021000@localhost.localdomain>
	 <1150242897.21787.148.camel@stark>
	 <200606131959.47635.chase.venters@clientec.com>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 18:16:44 -0700
Message-Id: <1150247804.21787.212.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 19:59 -0500, Chase Venters wrote:
> On Tuesday 13 June 2006 18:54, Matt Helsley wrote:
> 
> >  	switch (type) {
> > -		case PROFILE_TASK_EXIT:
> > -			err = blocking_notifier_chain_register(
> > -					&task_exit_notifier, n);
> > -			break;
> >  		case PROFILE_MUNMAP:
> >  			err = blocking_notifier_chain_register(
> >  					&munmap_notifier, n);
> >  			break;
> >  	}
> 
> 	if (type == PROFILE_MUNMAP)
> 
> ?
>
> > @@ -140,14 +130,10 @@ int profile_event_register(enum profile_
> >  int profile_event_unregister(enum profile_type type, struct notifier_block
> > * n) {
> >  	int err = -EINVAL;
> >
> >  	switch (type) {
> > -		case PROFILE_TASK_EXIT:
> > -			err = blocking_notifier_chain_unregister(
> > -					&task_exit_notifier, n);
> > -			break;
> >  		case PROFILE_MUNMAP:
> >  			err = blocking_notifier_chain_unregister(
> >  					&munmap_notifier, n);
> >  			break;
> >  	}
> 
> Same...
> 
> Thanks,
> Chase

Hmm. Perhaps I ought to get rid of the condition and enum entirely then
change the names of the functions to profile_mmmap() and
profile_munmap().

	It really depends on what additional changes, if any, are expected
here. Since I don't have any plans to further modify profiling beyond
what I've outlined in these patches I'm not sure what the best course is
here.

Thanks,
	-Matt Helsley


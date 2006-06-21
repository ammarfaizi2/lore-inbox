Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWFUIsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWFUIsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWFUIsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:48:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44214 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751298AbWFUIsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:48:36 -0400
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE <lse-tech@lists.sourceforge.net>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, "John T. Kohl" <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
In-Reply-To: <20060619032453.2c19e32c.akpm@osdl.org>
References: <1150242721.21787.138.camel@stark>
	 <20060619032453.2c19e32c.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 01:35:29 -0700
Message-Id: <1150878929.21787.956.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 03:24 -0700, Andrew Morton wrote:
> On Tue, 13 Jun 2006 16:52:01 -0700
> Matt Helsley <matthltc@us.ibm.com> wrote:
> 
> > Task watchers is a notifier chain that sends notifications to registered
> > callers whenever a task forks, execs, changes its [re][ug]id, or exits.
> 
> Seems a reasonable objective - it'll certainly curtail (indeed, reverse)
> the ongoing proliferation of little subsystem-specific hooks all over the
> core code, will allow us to remove some #includes from core code and should
> permit some more things to be loaded as modules.
> 
> But I do wonder if it would have been better to have separate chains for
> each of WATCH_TASK_INIT, WATCH_TASK_EXEC, WATCH_TASK_UID, WATCH_TASK_GID,
> WATCH_TASK_EXIT.  That would reduce the number of elements which need to be
> traversed at each event and would eliminate the need for demultiplexing at
> each handler.

	It's a good idea, and should have the advantages you cited. My only
concern is that each task watcher would have to (un)register multiple
notifier blocks. I expect that in most cases there would only be two.
Also, if we apply this to per-task notifiers it would mean that we'd
have a 6 raw notifier heads per-task.

	Would you like me to redo the patches as multiple chains? Alternately,
I could produce patches that apply on top of the current set.

Cheers,
	-Matt Helsley

PS: I've already picked up your warning fix.



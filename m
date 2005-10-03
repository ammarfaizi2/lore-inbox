Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbVJDAca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVJDAca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 20:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbVJDAca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 20:32:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:62872 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932729AbVJDAca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 20:32:30 -0400
Subject: Re: [PATCH 1/3] Process Notification / pnotify
From: Matt Helsley <matthltc@us.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Erik Jacobson <erikj@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       pagg@oss.sgi.com, "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <20051003124918.2a65ef41.pj@sgi.com>
References: <20051003184644.GA19106@sgi.com>
	 <20051003124918.2a65ef41.pj@sgi.com>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 16:19:26 -0700
Message-Id: <1128381567.12346.2569.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 12:49 -0700, Paul Jackson wrote:
> Hmmm ... I notice with interest two notification patches posted in
> the last few days to lkml:
> 
>   Matthew Helsley's Process Events Connector (posted 28 Sep 2005)
>   Erik Jacobson's pnotify (posted 3 Oct 2005)
> 
> I suspect Matthew and Erik will both instantly hate me for asking, but
> does it make sense to integrate these two?
> 
> If I understand these two proposals correctly:
> 
>     Helsley adds hooks in fork, exec, id change, and exit, to pass
>     events to userspace.
> 
>     Jacobson adds hooks in fork, exec and exit, to pass events to
>     kernel routines and loadable modules.
> 
> Perhaps, just brainstorming here, it would make sense for Halsley to
> register with pnotify instead of adding his own hooks in parallel.
> This presumes that pnotify is accepted into the kernel, and that
> pnotify adds the id change hook that Helsley requires.

Paul,

	pnotify is extreme overkill for the process events connector. The
per-task subscriber lists, data, inheritance of those lists, tasklist
locking, and iteration over the lists are all overhead compared to the
process events connector patch.

	For the process events connector it makes more sense to have a global
list of subscribers interested all tasks. If there are M kernel modules
interested in getting events for all N tasks this would save space
proportional to M*N compared to pnotify. Of course this means the
elements of this list could not have per-task data.

	I think per-task data should be split out from pnotify and submitted as
a separate system used by pnotify. Maybe with a *_PER_TASK API similar
to *_PER_CPU.

Cheers,
	-Matt Helsley


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbULHRCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbULHRCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbULHRCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:02:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:12749 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbULHRCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:02:21 -0500
Date: Wed, 8 Dec 2004 09:02:16 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>, dave@sr71.net,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: oops in proc_pid_stat() on task->real_parent?
Message-ID: <20041208090216.N2357@build.pdx.osdl.net>
References: <1102467332.19465.197.camel@localhost> <20041207220016.6917ee6f.akpm@osdl.org> <20041207220753.E469@build.pdx.osdl.net> <20041207221821.068568f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041207221821.068568f4.akpm@osdl.org>; from akpm@osdl.org on Tue, Dec 07, 2004 at 10:18:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Chris Wright <chrisw@osdl.org> wrote:
> >
> > * Andrew Morton (akpm@osdl.org) wrote:
> > > yup, we fixed that one.
> > 
> > I thought the same thing, but this oops is from proc_pid_stat, not
> > proc_pid_status.  The code is now in do_task_stat(), and the oops is
> > within the orignal tasklist lock (instead of dropping and reaquiring the
> > lock).  So, might be fixed, but if so, I think for a different reason.
> > 
> 
> Ah, thanks.
> 
> I'm not sure that the holding of tasklist_lock is going to save us there. 
> But then, Manfred recently did an audit, so I'm probably missing something.
> 
> Manfred, should we do this?

Yeah, I wondered the same.  Although I don't see why pid_alive() check
would be useful if it's the real_parent that's gone.  Dave mentioned
that he's got slab poisoning enabled, and the real_parent pointer was
valid (i.e. not 6b6b6b6b).  So wouldn't tasklist_lock serialize against
exiting real_parent?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

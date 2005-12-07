Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVLGBXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVLGBXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVLGBXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:23:25 -0500
Received: from xenotime.net ([66.160.160.81]:25325 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964852AbVLGBXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:23:24 -0500
Date: Tue, 6 Dec 2005 17:23:53 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: dsingleton@mvista.com, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: robust futex heap support patch
Message-Id: <20051206172353.79758246.rdunlap@xenotime.net>
In-Reply-To: <Pine.OSF.4.05.10512061404140.23158-100000@da410.phys.au.dk>
References: <EABD795D-6613-11DA-B91D-000A959BB91E@mvista.com>
	<Pine.OSF.4.05.10512061404140.23158-100000@da410.phys.au.dk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005 15:06:12 +0100 (MET) Esben Nielsen wrote:

> On Mon, 5 Dec 2005, david singleton wrote:
> 
> > 
> > On Dec 5, 2005, at 2:30 PM, Esben Nielsen wrote:
> > 
> > I'm currently trying to close a race condition between futex_wait_robust
> > and futex_wake_robust that Dave Carlson is seeing on his SMP system.
> > 
> > The scenario is as follows:
> > 
> > Thread A locks an pthread_mutex via the fast path and does not enter 
> > the kernel.
> > 
> > Thread B tries to lock the lock and sees it is already locked.  Thread 
> > B sets the
> > waiters flag in the lock and enters the kernel to lock the lock on 
> > behalf of
> > thread A and then block on the mutex waiting for it's release.
> > 
> > Thread A unlocks the lock and sees the waiters flag set.  Thread A gets
> > to the futex_wake_robust before Thread B can get to futex_wait_robust.
> > 
> > Thread A sees that it does not own the lock in the kernel and was 
> > returning EINVAL.
> > 
> > patch-2.6.14-rt21-rf8 was a preliminary patch for Dave Carlson to try 
> > and get more information about
> > the race condition.   ( rf8 and rf9 are still returning EAGAIN from 
> > thread B trying to
> > do the futex_wait_robust and the library should be retrying with 
> > EAGAIN, but it currently isn't).
> > 
> 
> *nod*
> I just pointed out that you can't make thread A loop the way you do.
> 
> What I would do was to do the user space flag checks while having the
> raw spinlock of the rt_mutex. That way you are sure that stuff in the
> kernel is serialized. But I don't know what to do exactly to do in
> there....
> 
> 
> > When I get the race condition closed I'll post the patch and notify 
> > everyone on lkml
> > and the robustmutexes mailing lists.
> 
> Where can I sign up to that mailing list? I would like to follow the
> development, although I don't have much time to contibute.

http://lists.osdl.org/mailman/listinfo/robustmutexes/


---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbTCMW5i>; Thu, 13 Mar 2003 17:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbTCMW5h>; Thu, 13 Mar 2003 17:57:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:40096 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262590AbTCMW5g>; Thu, 13 Mar 2003 17:57:36 -0500
Subject: Re: [PATCH] (1/8) Eliminate brlock in psnap
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: David Miller <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "" <linux-kernel-owner@vger.kernel.org>, "" <linux-net@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linus Torvalds <torvalds@transmeta.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC402C478.7A88360D-ON88256CE8.00785BB5@us.ibm.com>
From: Paul McKenney <Paul.McKenney@us.ibm.com>
Date: Thu, 13 Mar 2003 13:54:49 -0800
X-MIMETrack: Serialize by Router on D03NM116/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 03/13/2003 16:07:29
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > Module unloading should be rare enough to tolerate
> > the grace period under the module_mutex, right?
> >
> > Thoughts?
>
> I would agree. However can't unregister_snap_client be used in other
paths
> apart from module_unload? I wouldn't worry too much since if
> register_snap_client and unregister_snap_client for the same protocol
> races it's a bug in the caller's code. The safe RCU list removal and
> synchronize_kernel should protect us from sane usage.
>
>            Zwane

It is not called from elsewhere right now, but if there
is a possibility that it might be, Steve of course should
keep the locking in these functions.

                              Thanx, Paul


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVBGRUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVBGRUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVBGRUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:20:30 -0500
Received: from peabody.ximian.com ([130.57.169.10]:65453 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261201AbVBGRUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:20:08 -0500
Subject: Re: 2.6.11-rc3-mm1
From: Robert Love <rml@novell.com>
To: Peter Osterlund <petero2@telia.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <m3d5vdl6xi.fsf@telia.com>
References: <20050204103350.241a907a.akpm@osdl.org>
	 <m3d5vengs2.fsf@telia.com> <1107686024.30303.52.camel@gaston>
	 <m3acqhnaw3.fsf@telia.com>  <m3d5vdl6xi.fsf@telia.com>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 12:22:15 -0500
Message-Id: <1107796935.24154.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 22:22 +0100, Peter Osterlund wrote:

> > > >         EIP is a strncpy_from_user+0x33/0x47
> > > >         ...
> > > >         Call Trace:
> > > >          getname+0x69/0xa5
> > > >          sys_open+0x12/0xc6
> > > >          sysenter_past_esp+0x52/0x75
> > > >         ...
> > > >         Kernel panic - not syncing: Attempted to kill init!
> 
> I found the if I disable CONFIG_INOTIFY, the problem goes away.

Weird.  While we touch sys_open() with an inotify hook, we do so after
the call to getname, and we don't touch getname() or strncpy_from_user()
at all.

I wonder if there is another bug and inotify is just affecting the
timing?

	Robert Love



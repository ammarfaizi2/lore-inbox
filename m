Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTJRTuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJRTuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:50:12 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:44452 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261836AbTJRTuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:50:07 -0400
Date: Sat, 18 Oct 2003 15:46:17 -0400
From: Ben Collins <bcollins@debian.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: This bug appears under 2.6.0-test8 as well (was: 2.6.0-test7-mm1)
Message-ID: <20031018194617.GZ866@phunnypharm.org>
References: <20031018132741.GV866@phunnypharm.org> <20031018180741.69117.qmail@web40912.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018180741.69117.qmail@web40912.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 11:07:41AM -0700, Bradley Chapman wrote:
> Mr. Collins,

Oh, man, please don't use the "Mr." :)

> --- Ben Collins <bcollins@debian.org> wrote:
> > > 
> > > I was looking briefly at this too, and as you say, the problem is that 
> > > some things have to happen in interrupt, others happen in process 
> > > context.  I've attached a patch that implements one way to fix it: 
> > > double book-keeping - we maintain two lists of the highlevel drivers, 
> > > one protected by a semaphore another protected by the rw spinlock. The 
> > > lists are identical, except between the two list_add_tail()'s (and the 
> > > two list_del()'s), but that doesn't allow any harmful race conditions.
> > > 
> > > A more radical approach would be to split the highlevel interface into 
> > > two interfaces add_host() + remove_host() in a hpsb_host_notification 
> > > interface and the rest in another interface.  The driver would have to 
> > > register both interfaces if it needs them. Some drivers only use 
> > > add_host() and remove_host(), so they could register only the 
> > > hpsb_host_notification interface.
> > 
> > Actually I'm leaning toward getting rid of our internal locking and
> > reference counting and relying heavily on the device model's reference
> > counting and such. Take some of the work load off of our code.
> > 
> > Each host already has a device associated with it, so it just requires a
> > revamp of some internals.
> 
> JFYI, this bug also appears under 2.6.0-test8:

As would be expected considering I'm holding off changes to let 2.6
focus on core issues. The "bug" is pretty much harmless as-is, even if
noisy, and wont show up under normal compiles with debugging disables.

Plus, my fix is a little more than trivial, so I'm keeping it for 2.6.1.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264339AbTKZUWg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTKZUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:22:36 -0500
Received: from thunk.org ([140.239.227.29]:62679 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264339AbTKZUWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:22:34 -0500
Date: Wed, 26 Nov 2003 15:22:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-ID: <20031126202216.GA13116@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"David S. Miller" <davem@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126113040.3b774360.davem@redhat.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 11:30:40AM -0800, David S. Miller wrote:
> > - Doing gettimeofday on each incoming packet is just dumb, especially
> > when you have gettimeofday backed with a slow southbridge timer.
> > This shows quite badly on many profile logs.
> > I still think right solution for that would be to only take time stamps
> > when there is any user for it (= no timestamps in 99% of all systems) 
> 
> Andi, I know this is a problem, but for the millionth time your idea
> does not work because we don't know if the user asked for the timestamp
> until we are deep within the recvmsg() processing, which is long after
> the packet has arrived.

I believe what Andi was suggesting was if there was **no** processes
that are currently requesting timestamps, then we can dispense with
taking the timestamp.  If a single user asks for the timestamp, then
we would still end up taking timestamps on all packets.  Is this worth
the overhead to keep track of that factor?  It's arguable, but some
platforms, probably yes.

						- Ted

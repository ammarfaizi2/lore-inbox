Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVAKXJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVAKXJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVAKXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:09:53 -0500
Received: from waste.org ([216.27.176.166]:23485 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262866AbVAKXHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:07:18 -0500
Date: Tue, 11 Jan 2005 15:06:42 -0800
From: Matt Mackall <mpm@selenic.com>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111230642.GD2940@waste.org>
References: <20050111212823.GX2940@waste.org> <200501112248.j0BMmh9t006949@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501112248.j0BMmh9t006949@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 05:48:43PM -0500, Paul Davis wrote:
> >But I'm also still not convinced this policy can't be most flexibly
> >handled by a setuid helper together with the mlock rlimit.
> 
> This has been explained several times already.
> 
> When you run a JACK client, the user should not be required to use a
> different command sequence depending on whether or not JACK is running
> with RT scheduling or not. That's almost more arcane than the current
> situation and is a step backwards from even 2.4, where we use
> capabilities to allow JACK itself to pass on the ability to use RT
> scheduling and memlock to its clients.

And that is a failure of imagination on the part of the JACK
developers. Simply add a library function to libjack or whatever:

 jack_make_me_important(...); /* pretty please */

A client starts at normal priority, asks jack nicely to promote it to
RT, then jackd, if so configured/enabled, calls the wrapper with a PID
and a priority level. The wrapper checks the UID/priority/executable
name against its permission table and does sched_set{scheduler,param}
if allowed.

This is nice because Jack gets to make the decisions about what the
appropriate priorities for its clients are (eg they can't be higher
priority than jackd, etc.) and it all gracefully falls back if the
helper isn't enabled.

-- 
Mathematics is the supreme nostalgia of our time.

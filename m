Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVCHGww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVCHGww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVCHGwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:52:20 -0500
Received: from waste.org ([216.27.176.166]:51376 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261830AbVCHGuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:50:07 -0500
Date: Mon, 7 Mar 2005 22:49:36 -0800
From: Matt Mackall <mpm@selenic.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       joq@io.com, cfriesen@nortelnetworks.com, hch@infradead.org,
       rlrevell@joe-job.com, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050308064936.GP3120@waste.org>
References: <20050112185258.GG2940@waste.org> <200501122116.j0CLGK3K022477@localhost.localdomain> <20050307195020.510a1ceb.akpm@osdl.org> <20050308043349.GG3120@waste.org> <20050308064505.GJ5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308064505.GJ5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 10:45:05PM -0800, Chris Wright wrote:
> * Matt Mackall (mpm@selenic.com) wrote:
> > On Mon, Mar 07, 2005 at 07:50:20PM -0800, Andrew Morton wrote:
> > > Consider this a prod in the direction of those who were pushing
> > > alternatives ;)
> > 
> > I think Chris Wright's last rlimit patch is more sensible and ready to
> > go. And I think I may have even convinced Ingo on this point before
> > the conversation died last time around. So here's that patch again,
> > updated to 2.6.11. Compiles cleanly. Chris, please add a signed-off-by.
> 
> Only very minor nits below.
> 
> > Add a pair of rlimits for allowing non-root tasks to raise nice and rt
> > priorities. Defaults to traditional behavior. Originally written by
> > Chris Wright.
> > 
> > Signed-off-by: Matt Mackall <mpm@selenic.com>
> > 
> > Index: rlimits/include/asm-generic/resource.h
> > ===================================================================
> > --- rlimits.orig/include/asm-generic/resource.h	2005-03-02 18:30:27.000000000 -0800
> > +++ rlimits/include/asm-generic/resource.h	2005-03-07 20:21:04.000000000 -0800
> > @@ -20,8 +20,10 @@
> >  #define RLIMIT_LOCKS		10	/* maximum file locks held */
> >  #define RLIMIT_SIGPENDING	11	/* max number of pending signals */
> >  #define RLIMIT_MSGQUEUE		12	/* maximum bytes in POSIX mqueues */
> > -
> > -#define RLIM_NLIMITS		13
> > +#define RLIMIT_NICE	13		/* max nice prio allowed to raise to
> > +					   0-39 for nice level 19 .. -20 */
> > +#define RLIMIT_RTPRIO	14		/* maximum realtime priority */
> 
> Needs one more tab to keep in line with rest.

That's just tab damage from the patch.
 
> > +#define RLIM_NLIMITS		15
> 
> 
> >  #endif
> >  
> >  /*
> > @@ -53,6 +55,8 @@
> >  	[RLIMIT_LOCKS]		= { RLIM_INFINITY, RLIM_INFINITY },	\
> >  	[RLIMIT_SIGPENDING]	= { MAX_SIGPENDING, MAX_SIGPENDING },	\
> >  	[RLIMIT_MSGQUEUE]	= { MQ_BYTES_MAX, MQ_BYTES_MAX },	\
> > +	[RLIMIT_NICE]		= { 0, 0 }, \
> > +	[RLIMIT_RTPRIO]		= { 0, 0 }, \
> 
> Might as well fit in with rest of file on these too.
> 
> Also, missed alpha, sparc, sparc64, and mips.  BTW, where's that last
> cleanup from Ingo to consolidate these?  Ah, just saw these are inflight
> to Linus' tree, nevermind.

Uhh, is that not what I've already done above?
 
> -#define RLIM_NLIMITS		13
> +#define RLIMIT_NICE		13	/* max nice prio allowed to raise to
> +					   0-39 for nice level 19 .. -20 */
> +#define RLIMIT_RTPRIO		14	/* maximum realtime priority */

Heh.

Anyway...

-- 
Mathematics is the supreme nostalgia of our time.

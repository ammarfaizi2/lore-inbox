Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422913AbWF1Cah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422913AbWF1Cah (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 22:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422921AbWF1Cah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 22:30:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422913AbWF1Cag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 22:30:36 -0400
Date: Tue, 27 Jun 2006 19:30:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org, herbert@13thfloor.at,
       viro@ftp.linux.org.uk, serue@us.ibm.com
Subject: Re: [PATCH 00/20] Mount writer count and read-only bind mounts (v3)
Message-Id: <20060627193028.91b2e206.akpm@osdl.org>
In-Reply-To: <20060627192431.49388f2e.rdunlap@xenotime.net>
References: <20060627221436.77CCB048@localhost.localdomain>
	<20060627183822.667d9d49.akpm@osdl.org>
	<1151459436.24103.70.camel@localhost.localdomain>
	<20060627191727.406b0e18.akpm@osdl.org>
	<20060627192431.49388f2e.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 19:24:31 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Tue, 27 Jun 2006 19:17:27 -0700 Andrew Morton wrote:
> 
> > On Tue, 27 Jun 2006 18:50:36 -0700
> > Dave Hansen <haveblue@us.ibm.com> wrote:
> > 
> > > > > Since the last revision, the locking in faccessat() and
> > > > > mnt_is_readonly() has been changed to fix a race which might have
> > > > > caused a false-negative mount-is-readonly return when faccessat()
> > > > > is called while another two processes are racing to make a mount
> > > > > readonly.
> > > > > 
> > > > umm, what's it all for?
> > > 
> > > Mostly for vserver, for now.  They allow a filesystem to be r/w, but
> > > have r/o views into it.  This is really handy so that every vserver can
> > > use a common install but still allow the administrator to update it.
> > 
> > OK.  That makes it one of those features which stays in -mm until we work
> > out what we're going to do about containers/vserver/etc.
> > 
> > Unless there's something else which needs it?
> > 
> > This is all rather important info, you know.  It should be presented
> > front-and-centre in [patch 0/N].  In detail...
> 
> TPP says not to use patch 0/N.... !!?!!?!?!?
> so which way do you want it?
> 

Well.  I do tend to prefer that the big preamble be in [1/N] because git
doesn't support patches which have changelog and no diff (not that it
should).  But there's a certain sense in [0/N] when communicating by email.

But that's not the point.

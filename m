Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWBINVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWBINVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWBINVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:21:39 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:1989 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964774AbWBINVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:21:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 9 Feb 2006 14:22:39 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091245.34833.nigel@suspend2.net> <20060209092555.GB2940@elf.ucw.cz>
In-Reply-To: <20060209092555.GB2940@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602091422.40738.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 09 February 2006 10:25, Pavel Machek wrote:
> Good morning ;-).
> 
> > > At one point you said you'd like to work with us, and earlier in the
> > > threads you stated that porting suspend2 to userland should be easy.
> > > 
> > > [I do not think that putting suspend2 into git is useful thing to
> > > do. Of course, it is your option; but it seems to me that people
> > > likely to use suspend2 are not the kind of people that use git.]
> > > 
> > > It would be very helpful if you could install uswsusp, then try to
> > > make suspend2 run in userland on top of uswsusp interface. Not
> > > everything will be possible that way, but it most of features should
> > > be doable that way. I'd hate to code yet another splashscreen code,
> > > for example...
> > 
> > I've begun briefly to have a look at this.
> > 
> > Part of the problem I have, both with doing incremental patches for swsusp
> > and with doing a userspace version, is that some of the fundamentals are
> > redesigned in suspend2. The most important of these is that we store the
> > metadata in bitmaps (for pageflags) and extents (for storage) instead of
> > pbes. Do you have thoughts on how to overcome that issue? Are you
> > willing, for example, to do work on switching swsusp to use a different
> > method of storing its data?
> 
> Any changes to userspace are a fair game. OTOH kernel provides linear
> image to be saved to userspace, and what it uses internally should not
> be important to userland parts. (And Rafael did some changes in that
> area to make it more effective, IIRC). 

Yes.  The code is now split into the part that handles the snapshot image
(in snapshot.c) and the part that writes/reads it to swap (in swap.c). [I'm
referring to recent -mm kernels.]

The access to the snapshot image is provided via the functions
snapshot_write_next() and snapshot_read_next() that are called by the
code in swap.c and may be used by the user space tools via the
interface in user.c.  In principle it ought to be possible to plug
something else instead of the code in snapshot.c without
breaking the rest.

Greetings,
Rafael

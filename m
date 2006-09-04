Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWIDVoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWIDVoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWIDVoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:44:07 -0400
Received: from cs.columbia.edu ([128.59.16.20]:43209 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S965000AbWIDVoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:44:04 -0400
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification
	Filesystem
From: Shaya Potter <spotter@cs.columbia.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
In-Reply-To: <20060904203346.GA6646@elf.ucw.cz>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
	 <20060903110507.GD4884@ucw.cz>
	 <1157376506.4398.15.camel@localhost.localdomain>
	 <20060904203346.GA6646@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 17:43:04 -0400
Message-Id: <1157406184.4398.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter1.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 22:33 +0200, Pavel Machek wrote:
> On Mon 2006-09-04 09:28:26, Shaya Potter wrote:
> > On Sun, 2006-09-03 at 11:05 +0000, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > - Modifying a Unionfs branch directly, while the union is mounted, is
> > > >   currently unsupported.  Any such change may cause Unionfs to oops and it
> > > >   can even result in data loss!
> > > 
> > > I'm not sure if that is acceptable. Even root user should be unable to
> > > oops the kernel using 'normal' actions.
> > 
> > As I said in the other case.  imagine ext2/3 on a a san file system
> > where 2 systems try to make use of it.  Will they not have issues?
> 
> They probably will have issues (altrough I'm not sure, perhaps ext2
> has been debugged enough), but they'll fix them (as opposed to
> document that oopses are okay).

I agree that unionfs shouldn't oops, it should handle that situation in
a more graceful manner, but once the "backing store" is modified
underneath it, all bets are off for either unionfs or ext2/3 behaving
"correctly" (where "correctly" doesn't just mean handle the error
gracefully).

But are you also 100% sure that messing with the underlying backing
store wouldn't be considered an admin bug as opposed to an administrator
bug? I mean there's nothing that we can do to prevent an administrator
from FUBAR'ing their system by 

dd if=/dev/random of=/dev/kmem.

where does one draw the line?  I agree that stackable file systems make
this a more pressing issue, as the "backing store" can be visible within
the file system namespace as a regular file system that people are
generally accustomed to interacting with.


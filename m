Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWIDXb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWIDXb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWIDXb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 19:31:59 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:34461 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S965037AbWIDXb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 19:31:57 -0400
Date: Mon, 4 Sep 2006 19:31:31 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060904233130.GB19836@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060903110507.GD4884@ucw.cz> <1157376506.4398.15.camel@localhost.localdomain> <20060904203346.GA6646@elf.ucw.cz> <1157406184.4398.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157406184.4398.24.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 05:43:04PM -0400, Shaya Potter wrote:
> On Mon, 2006-09-04 at 22:33 +0200, Pavel Machek wrote:
> > On Mon 2006-09-04 09:28:26, Shaya Potter wrote:
> > > On Sun, 2006-09-03 at 11:05 +0000, Pavel Machek wrote:
> > > > > - Modifying a Unionfs branch directly, while the union is mounted, is
> > > > >   currently unsupported.  Any such change may cause Unionfs to oops and it
> > > > >   can even result in data loss!
> > > > 
> > > > I'm not sure if that is acceptable. Even root user should be unable to
> > > > oops the kernel using 'normal' actions.
> > > 
> > > As I said in the other case.  imagine ext2/3 on a a san file system
> > > where 2 systems try to make use of it.  Will they not have issues?
> > 
> > They probably will have issues (altrough I'm not sure, perhaps ext2
> > has been debugged enough), but they'll fix them (as opposed to
> > document that oopses are okay).
> 
> I agree that unionfs shouldn't oops, it should handle that situation in
> a more graceful manner,

Agreed. The solution is to make the VFS little friendlier to stackable
filesystems. I'm not sure what the best way of accomplishing that would be.
There are some papers about it [1], but my gut feeling is that they are way
too invasive.

> but once the "backing store" is modified underneath it, all bets are off
> for either unionfs or ext2/3 behaving "correctly"
 
Exactly.
 
> where does one draw the line?  I agree that stackable file systems make
> this a more pressing issue, as the "backing store" can be visible within
> the file system namespace as a regular file system that people are
> generally accustomed to interacting with.

The unionfs (as well as any other stackable filesystem) case can be fixed up
by making the VFS aware of the stack - for example, by having some kind of
stackable filesystem callbacks.

Josef 'Jeff' Sipek.

[1] http://www.isi.edu/people/johnh/PAPERS/Heidemann95e.html

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition

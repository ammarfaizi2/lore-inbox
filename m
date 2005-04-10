Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVDJXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVDJXDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVDJXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:03:18 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:37626 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261629AbVDJXDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:03:10 -0400
Date: Sun, 10 Apr 2005 15:53:54 -0400
From: Christopher Li <lkml@chrisli.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050410195354.GH13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org> <20050410190331.GG13853@64m.dyndns.org> <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 03:38:39PM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 10 Apr 2005, Christopher Li wrote:
> > 
> > BTW, one thing I learn from ext3 is that it is very useful to have some
> > compatible flag for future development. I think if we want to reserve some
> > room in the file format for further development of git
> 
> Way ahead of you.
> 
> This is (one reason) why all git objects have the type embedded inside of 
> them. The format of all objects is totally regular: they are all 
> compressed with zlib, they are all named by the sha1 file, and they all 
> start out with a magic header of "<typename> <typesize><nul byte>".
> 
> So if I want to create a new kind of tree object that does the same thing 
> as the old one but has some other layout, I'd just call it something else. 
> Like "dir". That was what I initially planned to do about the change to 
> recursive tree objects, but it turned out to actually be a lot easier to 
> just encode it in the old type (that way the routines that read it don't 
> even have to care about old/new types - it's all the same to them).

Ha, that is right. You put the new type into same object trick me into
thinking I have to do the same way. Totally forget I can introduce new type
of objects. It is even cleaner. Cool.

How about deleting trees from the caches? I don't need to delete stuff from
the official tree. It is more for my local version control.
Here is the usage case,
- I check out the git.git.
- using quilt to build my series of patches, git-hack1, git-hack2.. git-hack6.
  let's say those are store in git cache as well
- I pick some of them come up with a clean one "submit.patch"
- submit.patch get merged into official git tree.
- Now I want to get rid of the hack1 to hack6, but how?

One way to do it is never commit hack1 to hack6 into git or cache. They stay as quilt
patches only. But it is very tempting to let quilt using git instead of the
.pc/ directory, quilt can simplify as some usage case of patch and git.

Chris


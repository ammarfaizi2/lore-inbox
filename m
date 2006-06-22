Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWFVSVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWFVSVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWFVSVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:21:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:17597 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751865AbWFVSVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:21:31 -0400
Date: Thu, 22 Jun 2006 11:18:26 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060622181826.GB22867@kroah.com>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org> <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 06:22:58PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 21 Jun 2006, Greg KH wrote:
> > 
> > Ok, but how?  I'm generating the diffstat in my script with:
> > 
> > 	git diff origin..HEAD | diffstat -p1 >> $TMP_FILE
> 
> Btw, with a recent git (ie 1.4.0+), you can just do
> 
> 	git diff -M --stat origin..HEAD
> 
> to do that much more efficiently, and without any external dependency on 
> the "diffstat" program (with rename detection, you really need to do this 
> using git itself, because "diffstat" doesn't understand rename patches 
> being renames).

Great, thanks, that works fine.  And it's faster :)

> In fact, in a script, add the "--summary" option too, which gives a 
> summary of file creation/deletion/renames at the end.

Ok, will do.  The next pull I send you will have the new format.

> And as usual, the diff options work fine with "git log" too, so you can do
> 
> 	git log -M --stat --summary
> 
> and it will do the right thing. Look at your ae0dadcf.. commit, for 
> example.
> 
> Btw, the _one_ thing to be careful about is that when you generate a real 
> patch with "-M", if that patch actually has a rename, then only "git 
> apply" will be able to apply it correctly, and if somebody uses a regular 
> "patch" program to apply it, they'll miss out on the rename, of course.
> 
> Some day maybe the git "extended patch format" is so univerally recognized 
> to be superior that everybody understands them, in the meantime you may 
> not want to use "-M" to generate patches unless you know the other end 
> applies them with git.
> 
> (Which also explains why "-M" is not the default, of course).

For now I'll leave -M off, as people might want to apply the patches
from email.  Although it might cut down on main bandwidth, and they can
always refer to the git tree or original patch...  I'll think about that
one.

thanks,

greg k-h

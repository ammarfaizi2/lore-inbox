Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWIMT6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWIMT6U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWIMT6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:58:20 -0400
Received: from 1wt.eu ([62.212.114.60]:39186 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751154AbWIMT6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:58:19 -0400
Date: Wed, 13 Sep 2006 21:49:14 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, David Wagner <daw@cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
Message-ID: <20060913194914.GI541@1wt.eu>
References: <20060907182304.GA10686@danisch.de> <45073B2B.4090906@lsrfire.ath.cx> <ee7m7r$6qr$1@taverner.cs.berkeley.edu> <20060913043319.GH541@1wt.eu> <ee8589$e70$1@taverner.cs.berkeley.edu> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com> <Pine.LNX.4.61.0609130823430.17906@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609130823430.17906@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 08:26:57AM +0200, Jan Engelhardt wrote:
> >> 
> >> Ahh, thanks for the explanation.  That's helpful.
> >> 
> >> So it sounds like git-tar-tree has a bug; its default isn't setting
> >> meaningful permissions on the files that it puts into the tar archive.
> >> I hope the maintainers of git-tar-tree will consider fixing this bug.
> >
> > Let me reiterate:  This is not a bug!
> >
> > Here are a few facts:
> >
> > 4)  When I run "tar -xvf foo.tar" as a normal user, the "tar" command uses
> > permissions from the archive for new files, which are modified by my umask
> > before hitting the FS.
> >
> > 5)  Do you see the pattern here?
> >
> > Now when I run that tar command as root, for some reason they assume that just
> > because my UID is 0 I want to try to ignore my umask while extracting my
> > j_random.tar file.  How does this follow from the behavior of any other
> > programs mentioned above?
> 
> > The program "git-tar-tree" has no bug.  It creates the tar archive such that
> > when extracted as a normal user the users' umask is applied exactly as for
> > every other standard program.  If anything the "bug" is in tar assuming that
> > every archive file extracted as UID 0 is a backup, or in the admin assuming
> > that tar doesn't behave differently when run as UID 0.
> 
> The 'complaint' made is that while the tar archive is created, 0666 gets
> written into it.

Let me repeat it : git-tar-tree can use a umask to set something different.

> However, most software projects out there always make sure
> that files are 0644 before tar -cvf'ing their tree.

The real problem IMHO is that many people got used for 10 years to receive
kernels packaged by user 'linus' with perms 0644, and suddenly their
(discutable) habits are considerably upset because of what initially was
a limitation in the tool, which was argumented as a feature and might not
change anytime now.

Moral of the story : do not ever try to convince Linus he's wrong
when you disagree with him, because the argument he will give you
will quickly become desired features :-)

> Jan Engelhardt

Regards,
Willy


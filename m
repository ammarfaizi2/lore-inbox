Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030449AbWIMEla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbWIMEla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 00:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbWIMEla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 00:41:30 -0400
Received: from 1wt.eu ([62.212.114.60]:36370 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751557AbWIMEl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 00:41:29 -0400
Date: Wed, 13 Sep 2006 06:33:19 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
Message-ID: <20060913043319.GH541@1wt.eu>
References: <20060907182304.GA10686@danisch.de> <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com> <ee796o$vue$1@taverner.cs.berkeley.edu> <45073B2B.4090906@lsrfire.ath.cx> <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 01:17:48AM +0000, David Wagner wrote:
> Rene Scharfe  wrote:
> >[details on how GNU tar works, snipped]
> 
> Again, you miss my point.  I already know how tar works, but that's not
> my point.  Why is it that people are so unwilling to address the real
> issue here?  Let's try a few facts:
> 
>     (a) The Linux kernel tar archive contains files with world-writeable
>     permissions.
> 
>     (b) There is no need for those files to have world-writeable
>     permissions.  It doesn't serve any particular purpose.  If the
>     permissions in the tar archive were changed to be not world-writeable,
>     no harm would be done.
> 
>     (c) Some users may get screwed over by virtue of the fact that those
>     files are listed in the tar archive with world-writeable permissions.
>     (Sure, if every user was an expert on "tar" and on security, then
>     maybe no one would get screwed over.  But in the real world, that's
>     not the case.)
> 
>     (d) Consequently, the format of the Linux kernel tar archive is
>     exposing some users to unnecessary riskis.
> 
>     (e) The Linux kernel folks could take a quick and easy step that
>     would eliminate this risk.  That step would involve storing the
>     files in the tar archive with permissions that were more reasonable
>     (not world-writeable would be a good start!).  This step wouldn't
>     hurt anyone.  There's no downside.
> 
>     (f) Yet the Linux kernel folks refuse to take this step, and any
>     time someone mentions that there is something the Linux kernel folks
>     could do about the problem, someone tries to change the topic to
>     something else (e.g., complaints about bugs in GNU tar, suggestions
>     that the user should invoke tar with some other option, claims that
>     this question has been addressed before, you name it).
> 
> So why is it that the tar archive is structured this way?  Why are
> the Linux kernel folks unnecessarily exposing their users to risk?
> What purpose, exactly, does it serve to have these files stored with
> world-writeable permissions?
> 
> Folks on the Linux kernel mailing list seem to be reluctant to admit these
> facts forthrightly.  The posts I've seen mostly seem to have little or
> no sympathy for users who get screwed over.  The attitude seems to be:
> if you get screwed over, it's your fault and your problem.  Why is that?
> If there is a simple step that Linux developers can take to eliminate
> this risk, why is there such reluctance to take it, and why is there
> such eagerness to point the finger at someone else?
> 
> The way I see it, storing files in a tar archive with world-writeable
> permissions is senseless.  Why do such a strange thing on purpose?
> 
> It all seems thoroughly mysterious to me.

The initial reason is that Linus now uses the "git-tar-tree" command
which creates the full tar archive from the tree. It does not use tar,
it know how to produce the tar format itself. The command has to set
permissions on the files, and by default, it sets full permissions to
the files. This began in early git history. Recently, I've been using
git for another project. There, it has annoyed me to put such
permissions in tar files which mostly contained scripts. So I proposed
a patch to add the umask option to the repository config file which
solved my problem. Junio merged it into git 1.4.2 (so it's very recent).
It would be perfectly usable for linux too (in fact, I do use it on the
2.4 tree).

Maybe you should ask Linus if he considers using this ? When he initially
refused doing anything, it was when every single change would have needed
to change git. Now that git has changed, maybe Linus would consider going
back to the old behaviour ?

Regards,
Willy


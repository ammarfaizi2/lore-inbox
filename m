Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWIMG1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWIMG1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWIMG1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:27:48 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:30407 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751620AbWIMG1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:27:47 -0400
Date: Wed, 13 Sep 2006 08:26:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
In-Reply-To: <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com>
Message-ID: <Pine.LNX.4.61.0609130823430.17906@yvahk01.tjqt.qr>
References: <20060907182304.GA10686@danisch.de> <45073B2B.4090906@lsrfire.ath.cx>
 <ee7m7r$6qr$1@taverner.cs.berkeley.edu> <20060913043319.GH541@1wt.eu>
 <ee8589$e70$1@taverner.cs.berkeley.edu> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> Ahh, thanks for the explanation.  That's helpful.
>> 
>> So it sounds like git-tar-tree has a bug; its default isn't setting
>> meaningful permissions on the files that it puts into the tar archive.
>> I hope the maintainers of git-tar-tree will consider fixing this bug.
>
> Let me reiterate:  This is not a bug!
>
> Here are a few facts:
>
> 4)  When I run "tar -xvf foo.tar" as a normal user, the "tar" command uses
> permissions from the archive for new files, which are modified by my umask
> before hitting the FS.
>
> 5)  Do you see the pattern here?
>
> Now when I run that tar command as root, for some reason they assume that just
> because my UID is 0 I want to try to ignore my umask while extracting my
> j_random.tar file.  How does this follow from the behavior of any other
> programs mentioned above?

> The program "git-tar-tree" has no bug.  It creates the tar archive such that
> when extracted as a normal user the users' umask is applied exactly as for
> every other standard program.  If anything the "bug" is in tar assuming that
> every archive file extracted as UID 0 is a backup, or in the admin assuming
> that tar doesn't behave differently when run as UID 0.

The 'complaint' made is that while the tar archive is created, 0666 gets
written into it. However, most software projects out there always make sure
that files are 0644 before tar -cvf'ing their tree.


Jan Engelhardt
-- 

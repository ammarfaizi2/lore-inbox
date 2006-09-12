Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWILW4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWILW4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWILW4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:56:46 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:18113
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932339AbWILW4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:56:45 -0400
Message-ID: <45073B2B.4090906@lsrfire.ath.cx>
Date: Wed, 13 Sep 2006 00:56:43 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: R: Linux kernel source archive vulnerable
References: <20060907182304.GA10686@danisch.de> <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com> <ee72if$sng$1@taverner.cs.berkeley.edu> <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com> <ee796o$vue$1@taverner.cs.berkeley.edu>
In-Reply-To: <ee796o$vue$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner schrieb:
> You misunderstand my point.  I don't care whether it is a tar bug or 
> not. I'm not claiming it is a tar bug.  I'm saying that people on 
> those threads claimed that this is a tar bug and used that as an 
> excuse to do nothing about the problem of world-writeable files in 
> the Linux tar archive. I'm saying that's a lousy excuse.  What I'm 
> saying is that, even if we accept that it is a tar bug, that's not a 
> good excuse for doing nothing about the problem.  Of course, if it is
> not a tar bug, then that makes it an even weaker excuse.

GNU tar offers two options on how to interpret the security mode bits in
a tar archive when you extract files from it: it either applies your
umask or it doesn't.

If you let it apply your umask and the mode in the archive is 0777 then
the extracted files will get exactly the permission you want them to
have.  E.g. you could grant group write rights, all without running chmod.

It may be unfortunate that GNU tar defaults to not apply the umask when
run as root, thereby trusting the permissions in the archive.  However,
this is not a bug but rather a feature which made sense back when tar
files were primarily used as backup files and not as transport containers.

So, don't run tar in local backup restore mode if you deal with archives
created by someone else, unless you want to set the permissions exactly
as they are stored in the archive.  If you are root then you should know
that GNU tar defaults to the permission preserving mode and how to
switch to umask applying mode.

René

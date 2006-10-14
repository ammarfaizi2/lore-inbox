Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWJNKOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWJNKOa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 06:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWJNKOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 06:14:30 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:25574
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751854AbWJNKOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 06:14:30 -0400
Message-ID: <4530B897.3010403@lsrfire.ath.cx>
Date: Sat, 14 Oct 2006 12:14:47 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Shawn Starr <shawn.starr@rogers.com>, Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bzip2 tarball 2.6.19-rc2 packaged wrong?
References: <200610132336.21392.shawn.starr@rogers.com>
In-Reply-To: <200610132336.21392.shawn.starr@rogers.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr schrieb:
> Linus, something in git  broke the prepackaged tarball/bzip2 generation?
> 
> $ tar -jxvf linux-2.6.19-rc2.tar.bz2
> linux-2.6.19-rc2.gitignore
> linux-2.6.19-rc2COPYING
> linux-2.6.19-rc2CREDITS
> linux-2.6.19-rc2Documentation/
> linux-2.6.19-rc2Documentation/00-INDEX
> linux-2.6.19-rc2Documentation/ABI/
> linux-2.6.19-rc2Documentation/ABI/README
> 
> -rc1 was ok.

Perhaps tar generation has been switched to using git-archive instead of
git-tar-tree?  There's an, admittedly, subtle difference in how the two
handle prefixes/basedirs.  The following two commands do the same:

   $ git-tar-tree rev basedir
   $ git-archive --prefix=basedir/ rev

If you use --prefix and you want a base directory then you have to
provide your own slash (basedir = prefix + path_separator).

René

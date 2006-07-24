Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWGXJ4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWGXJ4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 05:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWGXJ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 05:56:11 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:6857
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751111AbWGXJ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 05:56:09 -0400
Message-ID: <44C4992E.3070706@lsrfire.ath.cx>
Date: Mon, 24 Jul 2006 11:55:58 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: linux-kernel@vger.kernel.org, git@vger.kernel.org,
       Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Can't clone Linus tree
References: <20060724080752.GA8716@irc.pl>
In-Reply-To: <20060724080752.GA8716@irc.pl>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz schrieb:
>  Hi,
> 
>  yesterdat I wanted to bisect my kernel problem, but failed at first step:
> cloning Linus' tree. Today I tried it on other system and also failed.
> 
>  This is git-1.4.0 on Slackware, i586:
> 
> %  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-git
> fatal: packfile '/home/zdzichu/linux-git/.git/objects/pack/tmp-1jI4AH' SHA1 mismatch
> error: git-fetch-pack: unable to read from git-index-pack
> error: git-index-pack died with error code 128
> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.
> 
>  And this is 1.4.0-1.fc5 on FC5, x86_64:
> % git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-git
> fatal: packfile '/home/tomek/linux-git/.git/objects/pack/tmp-BxIcIC' SHA1 mismatch
> error: git-fetch-pack: unable to read from git-index-pack
> error: git-index-pack died with error code 128
> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.
> 
>  Errors occur constantly since yesterday. They of course appear after
> downloading several megabytes of data, which is unpleasant on my 128kbps
> connection.

Same here with both the master and next branch of git.  rsync as
suggested by Johannes Weiner works.  You can change the protocol
back to git in .git/remotes/origin after cloning; pulling small
changes seems to work fine.

strace tells me that safe_read at pkt-line.c:111 gets only 305 of
the expected 996 bytes and then dies.  I have no idea how that
might happen. :-/

Pulling the git repository works using the git protocol, btw.

René


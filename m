Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWAIDrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWAIDrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWAIDrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:47:14 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:32384 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751205AbWAIDrN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:47:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=utjpnQ6/QDKQxebYZLgRbON0PFRVvK++xY4NmbsHKTuiVKHqkZRukVBvyMbg03QAi5sAUQtDU0ba9Wxl7L+FUKqaYT9ngYZmcMCncx7SUnbiZpe4iWeykOzrcImhUlk8Q33UjiM9BS2jLTANPL9FFoE7psxn3WaHnwmsfsCiXsE=
Message-ID: <2cd57c900601081947l24598adm@mail.gmail.com>
Date: Mon, 9 Jan 2006 11:47:12 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Use git in scripts/setlocalversion
Cc: Ryan Anderson <ryan@michonline.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060104194203.GA2359@lsrfire.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060104194203.GA2359@lsrfire.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/1/5, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
> Currently scripts/setlocalversion is a Perl script that tries to figure
> out the current git commit ID of a repo without using git.  It also
> imports Digest::MD5 without using it and generally is too big for the
> small task it does. :]  And it always reports a git ID, even when the
> HEAD is tagged -- this is a bug.
>
> This patch replaces it with a Bourne Shell script that uses git
> commands to do the same.  I can't come up with a scenario where someone
> would use a git repo and refuse to install git core at the same time,
> so I think it's reasonable to assume git is available.
>
> The new script also reports uncommitted changes by adding -git_dirty to
> the version string.  Obviously you can't see from that _what_ has been
> changed from the last commit, so it's more of a reminder that you
> forgot to commit something.
>
> The script is easily extensible: simply add a check for Mercurial (or
> whatever) below the git check.
>
> Note: the script doesn't print a newline char anymore.  That's only
> because it was easier to implement it that way, not a feature (or bug).
> 'make kernelrelease' doesn't care.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 7c805c8..f54dac8 100644
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -1,56 +1,22 @@
> -#!/usr/bin/perl
> -# Copyright 2004 - Ryan Anderson <ryan@michonline.com>  GPL v2
> +#!/bin/sh

You didn't update the caller in the top Makefile, but that's ok.
--
Coywolf Qi Hunt

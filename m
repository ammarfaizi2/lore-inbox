Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbVINEoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbVINEoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbVINEoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:44:03 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:36411 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932620AbVINEoC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:44:02 -0400
Date: Wed, 14 Sep 2005 06:46:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ryan Anderson <ryan@michonline.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Auto-localversion doesn't detect tags correctly
Message-ID: <20050914044623.GA8099@mars.ravnborg.org>
References: <20050913082020.GF5276@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913082020.GF5276@mythryan2.michonline.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan.

> +++ linux-git/scripts/setlocalversion	2005-09-13 04:17:28.000000000 -0400
> @@ -36,13 +36,38 @@ sub do_git_checks {
>  	chomp $head;
>  	close(H);
>  
> -	opendir(D,".git/refs/tags") or return;
> +	unless (opendir(D,".git/refs/tags")) {
> +		warn "Failed to open .git/refs/tags : " . $!;
> +		return;
> +	}
>  	foreach my $tagfile (grep !/^\.{1,2}$/, readdir(D)) {
> -		open(F,"<.git/refs/tags/" . $tagfile) or return;
> +		unless (open(F,"<",".git/refs/tags/" . $tagfile)) {
> +			warn "Failed to open .git/refs/tags/$tagfile : " . $!;
> +			return;
> +		}
Can the two operations be done somehow using git commands?
With the above you assume all users have default setup with git files in
.git, but one may decide for:
GIT/.git
kernel/<kernelsrc-tree>

and then use:
export GIT_DIR=../GIT/.git

You need to do some sanitycheck if git is installed first.
`which git-rev-list` or similar.

	Sam

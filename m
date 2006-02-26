Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWBZJAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWBZJAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 04:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWBZJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 04:00:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40355 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750873AbWBZJAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 04:00:47 -0500
Date: Sun, 26 Feb 2006 09:00:24 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
Message-ID: <20060226090024.GO27946@ftp.linux.org.uk>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de> <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de> <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org> <20060226001716.GL27946@ftp.linux.org.uk> <Pine.LNX.4.64.0602251626280.22647@g5.osdl.org> <44016956.2030609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44016956.2030609@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 03:39:50AM -0500, Jeff Garzik wrote:
> Any chance we could get 'git fetch --heads' ?
> 
> FWIW, I regularly blow away and create new heads, so the above is rather 
> long for people who use my repos.  A lot of them use rsync because when 
> you're tracking a repo with ever-changing branches, 'git pull' doesn't 
> really approximate "make local X look like remote X".

Speaking of which...  Shouldn't git clone bring in .git/HEAD for rsync:// URLs?
As it is, we end up with HEAD pointing to refs/master, which might simply
not be there.  For git:// we get .git/HEAD same as in remote repository,
so behaviour for rsync:// probably should be the same...

Looks like a missing rsync in git-clone, around
        rsync://*)
                rsync $quiet -av --ignore-existing  \
                        --exclude info "$repo/objects/" "$GIT_DIR/objects/" &&
                rsync $quiet -av --ignore-existing  \
                        --exclude info "$repo/refs/" "$GIT_DIR/refs/" || exit

Comments?

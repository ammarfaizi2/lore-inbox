Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWBZAkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWBZAkE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 19:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWBZAkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 19:40:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64701 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWBZAkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 19:40:03 -0500
Date: Sat, 25 Feb 2006 16:39:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org,
       Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [stable] [PATCH 1/2] sd: fix memory corruption by sd_read_cache_type
In-Reply-To: <20060226001716.GL27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0602251626280.22647@g5.osdl.org>
References: <tkrat.014f03dc41356221@s5r6.in-berlin.de>
 <20060225021009.GV3883@sorel.sous-sol.org> <4400E34B.1000400@s5r6.in-berlin.de>
 <Pine.LNX.4.64.0602251600480.22647@g5.osdl.org> <20060226001716.GL27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Feb 2006, Al Viro wrote:
> 
> ObGit: is there any way to fetch _all_ branches from remote, creating local
> branches with the same names if they didn't exist yet?  Ot, at least, get
> the full list of branches existing in the remote repository...

The magic is "git-ls-remote". In particular, the "--heads" flag limits it 
to just showing branch heads.

Then you can feed that into "git fetch", which takes the format 
"localname:remotename" to tell it how to fetch.

In other words, something like

	git fetch remote $(git ls-remote --heads remote | awk '{print $2":"$2}')

should do what you asked for.

		Linus

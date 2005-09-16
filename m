Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030601AbVIPFtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030601AbVIPFtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 01:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbVIPFtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 01:49:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24278 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030572AbVIPFtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 01:49:36 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Junio C Hamano <junkio@cox.net>
cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       tony.luck@intel.com
Subject: Re: Current state of GIT fetch/pull clients 
In-reply-to: Your message of "Thu, 15 Sep 2005 16:52:20 MST."
             <7vbr2tx51n.fsf@assigned-by-dhcp.cox.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Sep 2005 15:49:11 +1000
Message-ID: <8953.1126849751@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 16:52:20 -0700, 
Junio C Hamano <junkio@cox.net> wrote:
>What this means is that using objects/info/alternates mechanism
>in your repository is a bit premature as things currently stand,
>if you intend your repository to be used by the general public.

Clients using rsync can use a workaround, although it is a bit clumsy.
I do rsync for selected /pub/scm/linux/kernel/git/ trees, including
torvalds and aegl.  At one point Tony Luck (aegl) was using alternates,
with objects/info/alternates containing
/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects

As you described in your mail, rsync with alternates overwrites the
local file, so the local alternates ended up pointing at a local
directory that did not exist.  Creating a local symlink from
/pub/scm/linux/kernel/git to the local directory that contains the
torvalds and aegl directories worked around the problem.  git checkout
on the aegl tree was quite happy to follow the symlink and pick up most
of the files from torvalds.

No point in doing that now, Tony has reverted the aegl tree to a full
copy of Linus, instead of using alternates.


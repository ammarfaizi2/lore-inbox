Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbVLBQ72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbVLBQ72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVLBQ72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:59:28 -0500
Received: from mail.fieldses.org ([66.93.2.214]:26534 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750826AbVLBQ71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:59:27 -0500
Date: Fri, 2 Dec 2005 11:59:23 -0500
To: Nico Schottelius <nico-kernel@schottelius.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Daniel Aubry <kernel-acl@spam.kicks-ass.net>
Subject: Re: ACL Problem
Message-ID: <20051202165923.GA20542@fieldses.org>
References: <20051202164047.GN32690@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202164047.GN32690@schottelius.org>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 05:40:47PM +0100, Nico Schottelius wrote:
> Hello!
> 
> I've problems settings ACLs on differnt hosts:
> 
> - ext3 does not work anywhere, error as in not supported ACLs
> - reiserfs does not work either (does in support acls anyway?)
> - jfs with ACLs works fine, jfs without ACLs behaves correctly not beeing able to
>   set them
> - On xfs it works everwhere
> 
> Here's the output of those machines:
> 
> -----------------------------Host1: srsyg01-------------------------------------
> srsyg01:/home/server/git# setfacl -R -m g:lw1:rwx walderlift-db-verifizieren.git/description 
> setfacl: walderlift-db-verifizieren.git/description: Operation not supported
> srsyg01:/home/server/git# uname -a
> Linux srsyg01 2.6.12xenU #7 Sun Nov 6 13:54:56 CET 2005 i686 GNU/Linux
> srsyg01:/home/server/git# zcat /proc/config.gz | grep ACL
> CONFIG_EXT2_FS_POSIX_ACL=y
> CONFIG_EXT3_FS_POSIX_ACL=y
> CONFIG_FS_POSIX_ACL=y
> srsyg01:/home/server/git# mount | grep /home 
> /dev/sdb1 on /home type ext3 (rw)

You probably just need to do something like

	mount -oremount,acl /home

I can't figure out where this is documented, though.

--b.

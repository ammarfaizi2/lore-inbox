Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWCYQ5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWCYQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWCYQ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:57:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11791 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751019AbWCYQ53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:57:29 -0500
Date: Sat, 25 Mar 2006 17:57:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Possible NULL pointer dereference in fs/configfs/dir.c
Message-ID: <20060325165727.GC4053@stusta.de>
References: <1143068729.27276.1.camel@alice> <20060322232709.GD7844@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322232709.GD7844@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 03:27:09PM -0800, Joel Becker wrote:
> On Thu, Mar 23, 2006 at 12:05:29AM +0100, Eric Sesterhenn wrote:
> > this fixes coverity bug #845, if group is NULL,
> > we dereference it when setting up dentry.
> 
> 	Is the converity checker merly looking at in-function patterns?
> Where can I access the bug report (sorry for the question).
> 	group cannot be null here, we aren't called any other way.  So
> while you are correct that the code below is needed in the presence of a
> NULL group, really the "if (group" isn't necessary, just the "if
> (group->default_groups)".  I could even BUG_ON() if you'd like.

Coverity is correct that something is wrong:

<--  snip  -->

...
        struct dentry *dentry = group->cg_item.ci_dentry;
        int ret = 0;
        int i;

        if (group && group->default_groups) {
...

<--  snip  -->

The question is only whether the dereferencing is a real bug or there's 
only the harmless issue of a superfluous check.

> Joel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


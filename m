Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWCYQ7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWCYQ7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWCYQ7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:59:11 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12815 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751065AbWCYQ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:59:10 -0500
Date: Sat, 25 Mar 2006 17:59:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Possible NULL pointer dereference in fs/configfs/dir.c
Message-ID: <20060325165908.GD4053@stusta.de>
References: <1143068729.27276.1.camel@alice> <20060322232709.GD7844@ca-server1.us.oracle.com> <1143070614.27446.4.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143070614.27446.4.camel@alice>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 12:36:54AM +0100, Eric Sesterhenn wrote:
>...
> On Wed, 2006-03-22 at 15:27 -0800, Joel Becker wrote:
>...
> > 	group cannot be null here, we aren't called any other way.  So
> > while you are correct that the code below is needed in the presence of a
> > NULL group, really the "if (group" isn't necessary, just the "if
> > (group->default_groups)".  I could even BUG_ON() if you'd like.
> 
> I would then propose the following patch, so the check can be
> removed for people who like small kernels. I dont think gcc notices
> that all callers use non-NULL values and optimizes it away.
> 
> --- linux-2.6.16/fs/configfs/dir.c.orig	2006-03-23 00:31:16.000000000 +0100
> +++ linux-2.6.16/fs/configfs/dir.c	2006-03-23 00:32:07.000000000 +0100
> @@ -504,7 +504,9 @@ static int populate_groups(struct config
>  	int ret = 0;
>  	int i;
>  
> -	if (group && group->default_groups) {
> +	BUG_ON(!group);		/* group == NULL is not allowed */
> +	
> +	if (group->default_groups) {
>...

Why do we need a BUG_ON() if we already got an Oops?
Simply remove the check.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTIKWuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbTIKWuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:50:20 -0400
Received: from users.linvision.com ([62.58.92.114]:6101 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S261575AbTIKWuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:50:14 -0400
Date: Fri, 12 Sep 2003 00:50:08 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Reiser3/4 & Ext2/3 was: First impressions of reiserfs4
Message-ID: <20030912005007.B11566@bitwizard.nl>
References: <20030908113304.A28123@bitwizard.nl> <20030908094825.GD10487@namesys.com> <20030908120531.A28937@bitwizard.nl> <20030908101704.GE10487@namesys.com> <20030908222457.GB17441@matchmail.com> <20030909070421.GJ10487@namesys.com> <20030909191044.GB28279@matchmail.com> <20030911102938.GE29357@namesys.com> <20030911171513.GA18399@matchmail.com> <20030911172740.GK29357@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911172740.GK29357@namesys.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 09:27:40PM +0400, Oleg Drokin wrote:
> > > as are superblock, journal and journal header.
> > How many superblocks are there in reiser3?  Also, the bitmap locations are
> 
> One superblock.

As we've experienced that it's possible to lose the one-and-only 
superblock, I would recommend that you build a backup superblock
in the future. Of course you're going to argue that some parameters
constantly change in the superblock so that it would mean a performance
penalty to have two of them. Well, the backup superblock should
be marked and used as such: It will allow a more "easy" recovery
of the filesystem parameters, should the primary be "gone", but 
it should not interfere with "normal operation". So, feel free to
only update it once every ten minutes or so. Or just initialize
it and only write it when the fs is unmouted. Or don't update it 
at all. But no backup superblock, is just plain wrong. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****

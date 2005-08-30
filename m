Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVH3JSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVH3JSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 05:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVH3JSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 05:18:30 -0400
Received: from styx.suse.cz ([82.119.242.94]:22480 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751268AbVH3JS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 05:18:29 -0400
Date: Tue, 30 Aug 2005 11:18:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Machida, Hiroyuki" <machida@sm.sony.co.jp>, linux-kernel@vger.kernel.org,
       hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #2
Message-ID: <20050830091843.GA9288@midnight.suse.cz>
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp> <84144f02050830015523df031e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f02050830015523df031e@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 11:55:46AM +0300, Pekka Enberg wrote:
> Hi,
> 
> Some more.
> 
> On 8/30/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> > --- old/fs/fat/inode.c  2005-08-29 09:38:53.308587787 +0900
> > +++ new/fs/fat/inode.c  2005-08-29 09:39:33.889555606 +0900
> > @@ -345,6 +347,15 @@ static void fat_delete_inode(struct inod
> >  static void fat_clear_inode(struct inode *inode)
> >  {
> >         struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
> > +       void *hints;
> > +
> > +       down(&(MSDOS_I(inode)->scan_lock);
> > +       hints = (void *)(MSDOS_I(inode)->scan_hints);
> > +       if (hints) {
> > +               MSDOS_I(inode)->scan_hints = 0;
> > +       }
> > +       up(&(MSDOS_I(inode)->scan_lock);
> > +       if (hints) kfree(hints);
> 
> Please just make the local variable hints of type loff_t * to get rid
> of the pointless casting.

For voids no casting is needed anyway, the type exists for the very
reason of being compatible with any other.

> >         if (is_bad_inode(inode))
> >                 return;
> > @@ -1011,6 +1022,8 @@ static int fat_read_root(struct inode *i
> >         struct msdos_sb_info *sbi = MSDOS_SB(sb);
> >         int error;
> > 
> > +       init_MUTEX(&(MSDOS_I(inode)->scan_lock);
> > +       MSDOS_I(inode)->scan_hints = 0;
> 
> Use NULLs instead of 0 for pointers to keep new code sparse-clean.
 
It's a good idea for readability, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

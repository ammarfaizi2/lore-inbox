Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTAQBnt>; Thu, 16 Jan 2003 20:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTAQBnt>; Thu, 16 Jan 2003 20:43:49 -0500
Received: from dp.samba.org ([66.70.73.150]:61087 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267352AbTAQBnt>;
	Thu, 16 Jan 2003 20:43:49 -0500
Date: Fri, 17 Jan 2003 12:38:27 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH] Proposed module init race fix.
Message-Id: <20030117123827.1abaf413.rusty@rustcorp.com.au>
In-Reply-To: <3E258DA5.4BB14A41@linux-m68k.org>
References: <20030115082444.13D1A2C128@lists.samba.org>
	<3E258DA5.4BB14A41@linux-m68k.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003 17:34:45 +0100
Roman Zippel <zippel@linux-m68k.org> wrote:
> >  void add_disk(struct gendisk *disk)
> >  {
> > +       /* It needs to be accessible so we can read partitions. */
> > +       make_module_live(disk->fops->owner);
> > +
> 
> After this the module can be removed without problems.

Good catch!  The core code should hold a reference during init.  This is
fixed in the new patch.

> >         disk->flags |= GENHD_FL_UP;
> >         blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
> >                         NULL, exact_match, exact_lock, disk);
> 
> blk_register_region() allocates memory, which can fail?

Looks like.  But the semantics are the same as before, for better or worse. 8(

Thanks!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy

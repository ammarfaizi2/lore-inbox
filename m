Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTAQWIu>; Fri, 17 Jan 2003 17:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTAQWIu>; Fri, 17 Jan 2003 17:08:50 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:37648 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261600AbTAQWIs>; Fri, 17 Jan 2003 17:08:48 -0500
Message-ID: <3E2822B9.B4DB7324@linux-m68k.org>
Date: Fri, 17 Jan 2003 16:35:22 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: Re: [PATCH] Proposed module init race fix.
References: <20030115082444.13D1A2C128@lists.samba.org>
		<3E258DA5.4BB14A41@linux-m68k.org> <20030117123827.1abaf413.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I take it as a good sign that I'm not in your .procmailrc yet. :-) )

Rusty Russell wrote:

> > >         disk->flags |= GENHD_FL_UP;
> > >         blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
> > >                         NULL, exact_match, exact_lock, disk);
> >
> > blk_register_region() allocates memory, which can fail?
> 
> Looks like.  But the semantics are the same as before, for better or worse. 8(

This means add_disk() can fail and according to your rules it can only
be called once. If add_disk() would called a second time, the module
would be live and add_disk() were not allowed to fail anymore.

bye, Roman



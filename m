Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTENXDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTENXDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:03:41 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:7687 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263084AbTENXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:03:39 -0400
Date: Thu, 15 May 2003 00:16:27 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
In-Reply-To: <20030514224212.GA8124@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0305142346380.14201-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, it would be nice to set the default font for newly created fonts

> Perhaps you need to make old ioctls 2.4.X compatible and introduce new
> ioctl that sets only "this" console?

PIO_FONTRESET ioctl which is old and the flag KD_FONT_OP_SET_DEFAULT.
I have to look at the setfont code to see if it sets this flag. I bet 
it doesn't. I don't see a flag to tell setfont to use this font as the 
default font for all terminals :-( The good news is you can tell which tty 
to change the fonts on (-c /dev/ttyX). So setfont has the idea of setting
a single tty but due to a bug in the console layer it set all terminals. 
I guess we need to update setfont for setting all terminals.

> Do this:
> 
> pavel@amd:~$ echo -e '\e[?8c'
> 
> Notice cursor changes to block. Switch to another console. Oops, block
> cursor, too.

Ug!!!! I have cursor_shape in struct display for this reason. Will have to 
trace to find the problem.

> > appears the flashing is the issue. I will see if a hardware cursor
> > also has

   Your right. I realize my logic error. I was literally thinking too black 
and white. In the case of a cursor that is a white thin line at the bottom 
and a grey background. That is whole cursor image!! The mask should be
the font image to be drawn. 
   You can think of it as the cursor being a big grey cookie with white 
frosting decoration on the bottom. Then I come with my font shape cookie 
cutter and cut it out.  

> >     KDGKBDTYPE.   (Wow, I can't believe we still have this. It should die)
> 
> What is that? I can not see it in 2.5.X.

Line 420 in vt_ioctl.c. 



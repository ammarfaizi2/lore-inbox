Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTENWbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTENWbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:31:34 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:52662 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263056AbTENWbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:31:32 -0400
Date: Thu, 15 May 2003 00:42:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030514224212.GA8124@elf.ucw.cz>
References: <20030514120950.GA302@elf.ucw.cz> <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > I'am wondering why setfont and loadkeys in setting only on first tty.
> > > > > It works (setting font map on all six tty) in 2.{2,4}.x.
> > > > > 
> > > > > I'am using _radeonfb_ with rv250if, could it be the reason?
> > > > 
> > > > FYI, its same as vesafb here.
> > > 
> > > Try this patch. If it works I will pass it on to linus. thank you.
> > 
> > Does not work. Setfont still only changes tty it is run on.
> 
> This is because I nuked a few global variables. Video_font_height and 
> video_scan_line where global variables. When you changed fonts it affected
> every terminal. Now you might think this is correct behavior but what 
> about systems with more than one graphics card. Say for example vgacon and 
> fbcon. Now for vgacon you can't change the width of your fonts but for 
> fbcon you can. So changing this global variable caused havoc for the VGA 
> text mode display. 

Well, it would be nice to set the default for newly created consoles.

Perhaps you need to make old ioctls 2.4.X compatible and introduce new
ioctl that sets only "this" console?

> > There are more problems. Emacs changes cursor to "more visible" one,
> > this somehow leaks between ttys.
> 
> Hm. I can't seem to reproduce this problem.

Do this:

pavel@amd:~$ echo -e '\e[?8c'

Notice cursor changes to block. Switch to another console. Oops, block
cursor, too.

> > Last but not least: Try this on your tty:
> > 
> > echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"
> > 
> > It is supposed to start "softcursor". Unfortunately, with 2.5.68+
> > softcursor is not cleared properly. Try typing foo^H^H^H in bash
> > :-(. [Or try most /some/file]. 
> 
> I see. Only moving the cursor to the left cause this problem. Moving right 
> is okay. Also hitting enter shows this problem. This is strange. It 

Its not. Its software generated cursor, and it is only drawn, not
properly hidden. Thats why it behaves like that.

> appears the flashing is the issue. I will see if a hardware cursor
> also has

Don't let flashing confuse you. Set it to the red block and you'll see
problem better.

>     KDGKBDTYPE.   (Wow, I can't believe we still have this. It should die)

What is that? I can not see it in 2.5.X.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

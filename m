Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTENWHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbTENWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:07:13 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32006 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262963AbTENWHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:07:12 -0400
Date: Wed, 14 May 2003 23:19:59 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
In-Reply-To: <20030514120950.GA302@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0305142248040.13403-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > I'am wondering why setfont and loadkeys in setting only on first tty.
> > > > It works (setting font map on all six tty) in 2.{2,4}.x.
> > > > 
> > > > I'am using _radeonfb_ with rv250if, could it be the reason?
> > > 
> > > FYI, its same as vesafb here.
> > 
> > Try this patch. If it works I will pass it on to linus. thank you.
> 
> Does not work. Setfont still only changes tty it is run on.

This is because I nuked a few global variables. Video_font_height and 
video_scan_line where global variables. When you changed fonts it affected
every terminal. Now you might think this is correct behavior but what 
about systems with more than one graphics card. Say for example vgacon and 
fbcon. Now for vgacon you can't change the width of your fonts but for 
fbcon you can. So changing this global variable caused havoc for the VGA 
text mode display. 

> There are more problems. Emacs changes cursor to "more visible" one,
> this somehow leaks between ttys.

Hm. I can't seem to reproduce this problem.
 
> Last but not least: Try this on your tty:
> 
> echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"
> 
> It is supposed to start "softcursor". Unfortunately, with 2.5.68+
> softcursor is not cleared properly. Try typing foo^H^H^H in bash
> :-(. [Or try most /some/file]. 

I see. Only moving the cursor to the left cause this problem. Moving right 
is okay. Also hitting enter shows this problem. This is strange. It 
appears the flashing is the issue. I will see if a hardware cursor also has
this same issue. Thanks for pointing it out. Softcursor has another 
problem I also discover also so I can include it in my next set of fixes.

P.S
    KDGKBDTYPE.   (Wow, I can't believe we still have this. It should die)




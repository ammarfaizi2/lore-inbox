Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTENPOW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTENPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:12:40 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:2236 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S262457AbTENPLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:11:08 -0400
Date: Wed, 14 May 2003 14:09:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Simmons <jsimmons@infradead.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.5.69 - no setfont and loadkeys on tty > 1
Message-ID: <20030514120950.GA302@elf.ucw.cz>
References: <20030511173817.GA2155@elf.ucw.cz> <Pine.LNX.4.44.0305122223570.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305122223570.14641-100000@phoenix.infradead.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'am wondering why setfont and loadkeys in setting only on first tty.
> > > It works (setting font map on all six tty) in 2.{2,4}.x.
> > > 
> > > I'am using _radeonfb_ with rv250if, could it be the reason?
> > 
> > FYI, its same as vesafb here.
> 
> Try this patch. If it works I will pass it on to linus. thank you.

Does not work. Setfont still only changes tty it is run on.

There are more problems. Emacs changes cursor to "more visible" one,
this somehow leaks between ttys.

Last but not least: Try this on your tty:

echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"

It is supposed to start "softcursor". Unfortunately, with 2.5.68+
softcursor is not cleared properly. Try typing foo^H^H^H in bash
:-(. [Or try most /some/file]. 

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264302AbUEIEhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264302AbUEIEhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 00:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUEIEhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 00:37:20 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15242
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264271AbUEIEhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 00:37:16 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Date: Sat, 8 May 2004 23:31:30 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <200405042018.23043.rob@landley.net> <20040508225401.GF29255@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040508225401.GF29255@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405082331.30669.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 May 2004 17:54, Pavel Machek wrote:
> Hi!
>
> > I'm one of the people for whom Patrick's suspend worked and yours didn't.
> >  Now I've been busy with other things for a couple months (Penguicon 2.0
> > went quite well, by the way), and there's talk of yanking Patrick's
> > suspend code from the kernel.  Right, so I've got to deal with this.  I
> > can't say I'm thrilled, but I DO want to continue to be able to suspend
> > my laptop.
> >
> > What kind of debug info do I need to report to get your suspend code
> > fixed, and who do I need to report it to?
> >
> > I just tested 2.6.5, which went "boing" trying to suspend with some kind
> > of debug message that gave me a hex number (not a panic, but I didn't
> > have a pen handy, I can try again and write it down if you like. 
> > Anything else I should do?)
>
> Try it with minimal drivers from signle user mode...

I'll give it a whack...

> > I asked Nigel a few months ago, and he pointed me to an enormous flag day
> > patch that will probably be integrated into the kernel when hell freezes
> > over.  (I have no idea why it's so intrusive, by the way.  Isn't half the
> > point of sysfs and the new 2.6 device infrastructure that finding all the
> > devices that need to be shut up doesn't require the kind of insanity
> > doing it under 2.4 did?
>
> Nigel's refrigerator is way more elaborate and very intrusive, but he
> seems to work *always*. Original refrigerator (shared by swsusp and
> pmdisk) only tries a bit and eventually gives up if stopping system is
> too hard. Hopefully Nigel's code can be simplified.

I hope so too.  Software suspend is a really nice feature, and he seems to be 
the one putting in the most time on it.

> > I read the docs and read through your code a bit, and every screenful or
> > so it says "this code is guaranteed to eat your data if you look at it
> > funny". I've been using Patrick's suspend code for something like eight
> > months now, and it never ate any of my data.  Failed to resume a few
> > times, but no worse than sync followed by yanking the power cord, fsck
> > did its thing and life went on.  (Yes, I back up regularly.  But I've
> > gotten the distinct impression that you have no faith whatsoever in your
> > own work, and reinstalling and restoring from backups is a real pain,
> > especially when you're on the road.)
>
> It did not eat *my* data in last eight months.
>
> If patrick does not warn you, its his problem.

Yeah, but his code works for me. :)

> If you suspend, mount
> your filesytems, do some work and then resume, you are probably going
> to do some pretty nasty corruption. Just don't do that.
>
> But this problem is shared by swsusp, swsusp2 *and* pmdisk.

I know.  I also know that ext2 (and derivatives) have both "last mounted" and 
"last written to" datestamp fields (other filesystems probably do as well, 
but I don't use 'em) and it would be really nice to check those as matching 
what they were when you suspended, and abort the resume if they don't 
match...

> > Sigh.  I _really_ don't have time for this right now.  I wonder if it
> > would be possible to just send Patrick some money?
>
> He's out of time, so money is not likely to help. Sending some money
> to Nigel might do the trick ;-).
> 								Pavel

His code isn't the one I've gotten to work yet... :)

Rob


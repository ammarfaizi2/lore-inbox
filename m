Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSGZJzm>; Fri, 26 Jul 2002 05:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGZJzm>; Fri, 26 Jul 2002 05:55:42 -0400
Received: from [195.39.17.254] ([195.39.17.254]:8320 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317406AbSGZJzl>;
	Fri, 26 Jul 2002 05:55:41 -0400
Date: Fri, 26 Jul 2002 11:57:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile warnings in suspend.c, 2.5.28
Message-ID: <20020726095721.GA220@elf.ucw.cz>
References: <20020725215312.GA489@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0207251501320.18430-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207251501320.18430-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Does it work for you? I get reboot after S4 on 2.5.28. Can you mail me
> > diff between clean and your tree?
> 
> Isn't the 'reboot after S4' due to #define TEST_SWSUSP 1?   I set it 
> to 0 and it shuts down properly for me.  I'm not sure why rebooting should 
> be the default behavior, actually -- it seems a bit strange.

Actually, I get two reboots. One expected after suspend and one
unexpected after resume.

TEST_SWSUSP is one so I can test it properly. I want to be Linus's
swsusp same as mine for 2.5. TEST_SWSUSP is going to be 0 at 2.6.

> My laptop's at home, but I applied the following patches from:
> 	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.28/
> 
> I applied the 2 rmap-related patches in order, then the remaining patches 
> (which are trivial cleanups and compile-fixes) in no special order.  
> 2.5.28-swsusp is the patch in this thread.  This won't change the "reboot 
> after S4" behavior without the additional change to TEST_SWSUSP,
> above. 

Can you do multiple S4 enters/leaves? Good test is to make bzImage
while doing while true; do echo 4 > /proc/acpi/sleep; sleep 30; done.

> Side note:
> The only change to suspend.c that I made which isn't covered by 
> the patch in this thread, is the try_to_free_pages() line -- 
> but this is specific to the "full rmap-VM for 2.5".  The big rmap patch 
> (2.5.28-rmap-1-rmap13b) makes this single alteration.

Okay.

> Second side note:
> For the vanilla 2.5 classzone VM, I don't honestly understand why we're 
> only looking at &contig_page_data.node_zones[ZONE_HIGHMEM] in
> try_to_free_pages().  On the other hand, I don't see how it would break
> swsusp.

I don't understand that line, either. Andrea told me to write it like
that, IIRC ;-).

> And a note of appreciation: :)
> This was the very first time I tried ACPI and swsusp! I had been using 
> APM before, but had no hibernation capability (my BIOS only worked 
> properly with suspend to RAM in Linux).  This is really a nice feature!
> 
> But now I have to figure out how to teach acpid to do useful stuff, like 
> throttle the CPU and try to S4 on lid close and such. :)

Throttling the CPU should be pretty easy [see
/proc/acpi/processor/0/*], and it should already enter sleep modes for
you.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?

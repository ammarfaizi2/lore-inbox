Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTBFTag>; Thu, 6 Feb 2003 14:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTBFTag>; Thu, 6 Feb 2003 14:30:36 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:20672 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S267352AbTBFTaf>; Thu, 6 Feb 2003 14:30:35 -0500
Date: Fri, 07 Feb 2003 08:41:27 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
In-reply-to: <20030206101645.GO1205@poup.poupinou.org>
To: Ducrot Bruno <ducrot@poupinou.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Message-id: <1044560486.1700.13.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206101645.GO1205@poup.poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 23:16, Ducrot Bruno wrote:
> On Thu, Feb 06, 2003 at 09:41:44AM +1300, Nigel Cunningham wrote:
> > Whether its slower depends on the hardware; on my 128MB Celeron 933
> > laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
> > back up and running in around a minute and a half. That's about the same
> > as far as I remember, but has (as you say) the advantage of not still
> > having to get things swapped back in.
> 
> The problem is the speed of the suspending process, not the whole suspend/resume
> sequence,  especially in case of emergency suspending due to thermal condition,
> etc.

Sorry. Perhaps I should have been clearer. I haven't spent a lot of time
doing timings, but there doesn't seem to be any significant difference.
In both versions, the amount of time varies with the amount of memory in
use. When not much memory is in use, both are fast because there's not
much to do anyway. When lots of memory is in use, both are slower. The
old version is slower because it eats as much memory as it can, and this
can take significant amounts of time, then makes a copy of every page
remaining, before saving those pages to disk. The new version doesn't
usually eat any memory, and when it does, not much is eaten. It then
saves all the pages that aren't needed for the suspend process directly
to disk; always more than half, sometimes all but about a few thousand
pages. It then uses this memory for the copy & save of remaining pages.
Thus, in one version, the major portion of time is taken in eating
memory (and post resume, loading pages back in) whereas in the 'new'
version, the time taken is almost purely a function of IO speed.

If you like, I'll do some timings on my 320MB desktop machine and post
them later in the day.

Regards,

Nigel


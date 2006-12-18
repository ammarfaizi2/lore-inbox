Return-Path: <linux-kernel-owner+w=401wt.eu-S1753640AbWLRJgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbWLRJgi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753639AbWLRJgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:36:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:44150 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640AbWLRJgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:36:37 -0500
Date: Mon, 18 Dec 2006 10:36:24 +0100
From: Stefan Seyfried <seife@suse.de>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: s2disk curiosity  :)
Message-ID: <20061218093624.GC960@suse.de>
References: <20061218100612.02d807f7@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061218100612.02d807f7@localhost>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-34-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 10:06:12AM +0100, Paolo Ornati wrote:
> Hello,
> 
> I'm using uswsusp and with commit
> 
> 	3592695c363c3f3119621bdcf5ed852d6b9d1a5c
> 	uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode")
> 
> 
> My PC power-light starts flashing during s2disk as expected (comment
> from the commit that fixes the same thing in in-kernel suspend):
> 
> "    [PATCH] swsusp: fix platform mode
> 
>     At some point after 2.6.13, in-kernel software suspend got "incomplete" for
>     the so-called "platform" mode.  pm_ops->prepare() is never called.  A
>     visible sign of this is the "moon" light on thinkpads not flashing during
>     suspend.  Fix by readding the pm_ops->prepare call during suspend."
> 
> 
> BUT: another thing that happens is that now my PC powers itself on
> _without_ pressing the power button (just by plugging the AC power).
> 
> 
> I don't like this all that much...
> 
> I understand this is probably MOBO specific but, is this behaviour
> expected/common?

Well, yes.
It depends on the BIOS. Many BIOSes have a setting where you can set the
"power fail mode" to "on", "off" or "as before". Now if you enter S4, the
BIOS might set the mode temporarily to "on" or whatever.
For example, many notebooks (have not tried lots of desktops :-) do a "very
quick boot mode" BIOS itialization if they went through the "proper" S4
sequence. On my toughbook and some FSC notebooks, this speeds up the
"power-button to GRUB"-time from ~10 seconds to ~1-2 seconds. The toughbook
even resumes from disk by just opening the lid.

This all is, however, BIOS specific. I have also seen BIOSes where it did
not matter at all.

If you don't like it, you can easily switch it off by 
"echo shutdown > /sys/power/disk" (in-kernel suspend) or by adding
"shutdown method = shutdown" to /etc/suspend.conf (userspace suspend).
You won't get the blinking light, though :-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270789AbTGNUXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270795AbTGNUVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 16:21:46 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:19841 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S270827AbTGNUR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 16:17:57 -0400
Date: Tue, 15 Jul 2003 08:30:08 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <20030714201804.GF902@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jamie Lokier <jamie@shareable.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058214607.3987.14.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <200307121734.29941.dtor_core@ameritech.net>
 <20030712225143.GA1508@elf.ucw.cz> <20030713133517.GD19132@mail.jlokier.co.uk>
 <20030713193114.GD570@elf.ucw.cz> <1058130071.1829.2.camel@laptop-linux>
 <20030713210934.GK570@elf.ucw.cz> <1058147684.2400.9.camel@laptop-linux>
 <20030714201245.GC24964@ucw.cz> <20030714201804.GF902@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm going to stand firm on this one, Pavel.

I think being able to cancel a suspend is a really useful feature, and
I'll be surprised if we don't see Microsoft including it in their next
version of Windows (perhaps I should take a patent out! :>)

That's not to say that I haven't listened to you, however. That's why I
tightened up the requirements for using it yesterday. As to the extra
proc entry, it's not a biggie: 2.4 swsusp now has it's own proc handling
code which is easily extensible. I did this to make it easier to
understand.

This...

[nigel@laptop-linux nigel]$ ls -l /proc/swsusp/
total 0
--w-------    1 root     root            0 Jul 15 08:28 activate
-rw-------    1 root     root            0 Jul 15 08:28 async_io_limit
-rw-------    1 root     root            0 Jul 15 08:28 beeping
-rw-------    1 root     root            0 Jul 15 08:28 checkpage
-rw-------    1 root     root            0 Jul 15 08:28 debug_sections
-rw-------    1 root     root            0 Jul 15 08:28 default_console_level
-rw-------    1 root     root            0 Jul 15 08:28 enable_escape
-rw-------    1 root     root            0 Jul 15 08:28 image_size_limit
-r--------    1 root     root            0 Jul 15 08:28 interface_version
-r--------    1 root     root            0 Jul 15 08:28 last_result
-rw-------    1 root     root            0 Jul 15 08:28 log_everything
-rw-------    1 root     root            0 Jul 15 08:28 no_async_reads
-rw-------    1 root     root            0 Jul 15 08:28 no_async_writes
-rw-------    1 root     root            0 Jul 15 08:28 no_output
-rw-------    1 root     root            0 Jul 15 08:28 nopageset2
-rw-------    1 root     root            0 Jul 15 08:28 pause_between_steps
-rw-------    1 root     root            0 Jul 15 08:28 progressbar_granularity_limit
-rw-------    1 root     root            0 Jul 15 08:28 reboot
-rw-------    1 root     root            0 Jul 15 08:28 slow
-r--------    1 root     root            0 Jul 15 08:28 version
[nigel@laptop-linux nigel]$ 

is easier to understand and configure. The /proc/sys/kernel/swsusp
interface is still there to make it easy to save & restore them all at
once.

Regards,

Nigel

On Tue, 2003-07-15 at 08:18, Pavel Machek wrote:
> Hi!
> 
> > > Having listened to the arguments, I'll make pressing Escape to cancel
> > > the suspend a feature which defaults to being disabled and can be
> > > enabled via a proc entry in 2.4. I won't add code to poll for ACPI (or
> > > APM) events :>
> > 
> > I'd suggest making it a mappable function in the keymap, like reboot is
> > for example. Both for initiating and stopping the suspend. How about
> > that?
> 
> Any user can load his own keymap, I believe... And I do not like
> having special /proc options for esc key...
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.


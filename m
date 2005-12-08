Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVLHBik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVLHBik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 20:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVLHBij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 20:38:39 -0500
Received: from ruth.realtime.net ([205.238.132.69]:64777 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S932273AbVLHBij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 20:38:39 -0500
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5ea338375b299708162887d8854df3ff@bga.com>
Content-Transfer-Encoding: 7bit
Cc: Russell King <rmkl@arm.linux.org.uk>, Olaf Hering <olh@suse.de>,
       Sachin Sant <sachinp@in.ibm.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Date: Wed, 7 Dec 2005 19:38:55 -0600
To: LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.623)
X-Server: High Performance Mail Server - http://surgemail.com r=-224271992
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 07 2005 - 18:38:41 EST, Russell King wrote:
> On Wed, Dec 07, 2005 at 11:22:46PM +0100, Olaf Hering wrote:
> > On Tue, Dec 06, Russell King wrote:
> >
> > > I'm still highly concerned about this whole idea. Applying this 
> patch
> > > _will_ without doubt inconvenience a lot of people who expect ^O 
> to be
> > > received as normal.
> >
> > If one boots with 'console=ttyS0', the 'ctrl o' should be handled 
> only
> > on ttyS0. However, I'm not sure if anyone uses ^O in this situation 
> via
> > the system console. In our case, ttyS0 is automatically activated via
> > add_preferred_console in arch/powerpc/kernel/setup-common.c.
> > If there is a clever way to handle ^O only for the system console, 
> would
> > such a patch be accepted? I'm currently looking through the code to 
> see
> > how it could be done.
>
> Easily. Have a look at the internals of uart_handle_break() in
> include/linux/serial_core.h
>
> However, please be aware that ^O is the default control character for
> "flush output" which I think is something you may want to use with a
> serial console. Eg:
>
> speed 38400 baud; rows 0; columns 0; line = 1;
> intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = <undef>;
> eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = 
> ^W;
> lnext = ^V; flush = ^O; min = 1; time = 0;
> ^^^^^^^^^^^
>
> Hence it's a poor choice. Maybe picking a character which isn't
> already used by default for another purpose would be appropriate?
> '^]', the classic telnet escape character maybe?

Aaarrrrhh NO!

Don't you ever login to a box to telent somewhere else?

I don't want to way 5 seconds to disconnect my telnet from the
hung remote machine (or do a saK either).

If this goes in, perhaps a parameter (which automatically shows
up in sysfs) to change it on the fly?  (ok, something tied to
the class device rather than the serial module would be nicer).

milton

[Hopefully I got all the cc's, I'm not subscribed]


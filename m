Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWG3M3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWG3M3q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 08:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWG3M3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 08:29:46 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:17425 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932301AbWG3M3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 08:29:45 -0400
Date: Sun, 30 Jul 2006 14:29:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Greg KH <greg@kroah.com>, lm-sensors@lm-sensors.org,
       Shem Multinymous <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-Id: <20060730142943.2537124e.khali@linux-fr.org>
In-Reply-To: <20060727232426.GI3797@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	<20060727221632.GE3797@elf.ucw.cz>
	<41840b750607271556n1901af3by2e4d046d68abcb94@mail.gmail.com>
	<20060727230801.GA30619@kroah.com>
	<20060727232426.GI3797@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > > We also need to decide on clear convention about units. Are they in
> > > the output and/or filename? Filename is best, I think, since it's
> > > impossible to miss and works nicely for input attributes too.
> > 
> > Actually, this whole thing could probably just go under the 'hwmon'
> > interface, as it already handles other hardware monitoring events.  I
> > don't see how a battery would be any different, do you?
> 
> Heh... yes, hwmon already has voltage, current, and more importantly,
> a maintainer.
> 
> I'd still prefer batteries to go into /sys/class/battery/... they are
> really different from lm78-style voltage sensor and I'd not expect
> battery applet to understand all the fields "normal" hwmon
> exports.

This probably doesn't matter much, every application can handle only
the subset it is interested in. For example a dockapp displaying the
system temperature only cares about the temp* files and ignores the
in*, fan*, etc. files.

However, it would be convenient if the battery monitoring application
had an easy (and non heuristic-based) way to distinguish between a
battery and a hardware monitoring chip. In that sense, having a
separate class makes sense. This doesn't prevent the battery drivers to
use the same conventions used by the hardware monitoring drivers.

> But conventions developed by hwmon group look sane and usable.

Nice to read this for a change, usually people have only complaints
about it ;)

> Actually I do not see "hwmon infrastructure" to exist. Every driver
> just uses sysfs directly. I'm not sure that the best option --
> "input-like" infrastructure can make drivers even shorter -- but
> perhaps just directly using sysfs is best for simple task like a battery?
> 
> Jean, any ideas?

I guess we never felt any need for an "infrastructure", else we would
have created it. I have no idea what the "input infrastructure" looks
like so I can't compare. If you have something to propose which would
refactor some code amongst the hardware monitoring drivers or would
otherwise makes thing better, speak up :)

Note that the hwmon class is merely a way to find out which devices
have hardware monitoring attributes. There are no class attributes in
use. The reason is historical, and also due to the fact that no two
hardware monitoring chips have the same set of features.

-- 
Jean Delvare

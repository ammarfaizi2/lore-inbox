Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVIVJkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVIVJkw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 05:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbVIVJkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 05:40:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:42711 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030265AbVIVJko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 05:40:44 -0400
Subject: Re: [RFC/BUG?] ide_cs's removable status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Mark Lord <liml@rtr.ca>, LKML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>, bzolnier@gmail.com,
       linux-ide@vger.kernel.org
In-Reply-To: <1127328385.20660.45.camel@localhost.localdomain>
References: <1127319328.8542.57.camel@localhost.localdomain>
	 <1127321829.18840.18.camel@localhost.localdomain> <433196B6.8000607@rtr.ca>
	 <1127327243.18840.34.camel@localhost.localdomain>
	 <1127328385.20660.45.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Sep 2005 01:18:09 +0100
Message-Id: <1127348289.18840.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-21 at 19:46 +0100, Richard Purdie wrote:
> CF slots have card detection and ide-cs will see a card removal event.
> Have a look at ide_event() in ide-cs.c: CS_EVENT_CARD_INSERTION and
> CS_EVENT_CARD_REMOVAL are what they say...

Not implemented on large numbers of adapters. Been there tried that,
been 2.4 IDE maintainer.

> This along with your comments about the IDE layer having no hotplug
> support suggest the code in question can be removed pending a better
> replacement when hotplug is implemented.

That attitude is why there is not hotplug code. Its the "delete anything
that gets in my way" approach. Its why 2.4 is the last kernel thats
useful on a thinkpad with removable drive bay.

The kernel isn't perfect so lets delete it and use DOS. Same argument,
same logical fallacy.

Also every other hotplug environment gets it right today, so GNOME and
KDE are doing things differently and it works. You can therefore do the
same.

The right approach is to ask

1.	Do you need to fix it, everyone elses userspace works maybe your user
space is inadequate and you need to use GNOME or KDE userspace
implementations (or steal the relevant algorithms)

2.	If it does need fixing (which I think you have a case for) then how
do I fix it properly

IDE CF cards have serial numbers. I believe the CF standard requires
they all do but I need to go re-read that to check. If so then you don't
want to remove the correct drive->removable handling (and break cache
flush etc too) but make the hotplug handler smarter. 

What does ->removable mean, "can go away without warning and detection".
That is true in this case. The problem you have is that the correctly
performed partition rescan generates events and you respond to them in a
way that gets you looping. That means either kernel or user space should
be asking "is this event for the same disk" and either not generating it
(because its not a change) or ignoring it in the user case.

But first of all you need to explain why GNOME and KDE work and your
code doesn't.

Alan


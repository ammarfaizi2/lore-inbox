Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759666AbWLCNNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759666AbWLCNNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759668AbWLCNNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:13:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51333 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1759666AbWLCNNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:13:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Stefan Reinauer <stepan@coresystems.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA490727C@ssvlexmb2.amd.com>
	<m1irgufl9q.fsf@ebiederm.dsl.xmission.com>
	<2ea3fae10612021247v33cfaa4evbc8ad1d5eaf196ba@mail.gmail.com>
	<m1ejrhfb9o.fsf@ebiederm.dsl.xmission.com>
	<20061203120130.GA32458@coresystems.de>
	<77E505A2-6E0B-422F-92AB-97395730A522@kernel.crashing.org>
	<20061203125250.GA17019@coresystems.de>
Date: Sun, 03 Dec 2006 06:11:57 -0700
In-Reply-To: <20061203125250.GA17019@coresystems.de> (Stefan Reinauer's
	message of "Sun, 3 Dec 2006 13:52:50 +0100")
Message-ID: <m1ac25f7j6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Reinauer <stepan@coresystems.de> writes:

> * Segher Boessenkool <segher@kernel.crashing.org> [061203 13:42]:
>> On LPC, yes -- or 0.5us or something like that.  On ISA it's
>> a lot faster, on PCI too -- better do 20 or so outb's to be
>> safe.
>
> The value's actually something we have been using as a rule of thumb
> while doing outb to port 80. Don't think these are routed to LPC, are
> they?

Depends on the destination address.  For 0x80 you can be fairly
certain it will be an unacknowledged cycle subtractively decoded
to the slowest bus on the system.  Or routed to 32 PCI or the LPC bus
if there is something to actually looking at the value so it is slow.

Since all I need is something that delays for about 50ms 50,000 outb
to port 0x80 looks like a good first approximation, and since it
only happens once it is probably better to just bump that count up
instead of trying to be precise about it and have an accurate timer.

I'm not at all convinced a usb console can be made sufficiently solid
to be useful.  But it is at least worth trying so we can clearly say
it doesn't work well.

Eric

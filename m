Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTFIWwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTFIWwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:52:31 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:32467 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262262AbTFIWwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:52:30 -0400
Date: Tue, 10 Jun 2003 11:09:29 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [RFC] New system device API
In-reply-to: <20030609220442.GD508@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1055200110.2119.9.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030609212348.GB508@elf.ucw.cz>
 <Pine.LNX.4.44.0306091428470.11379-100000@cherise>
 <20030609220442.GD508@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning, gentlemen.

Can I bring up an issue a little off topic? Is it currently possible for
us to say 'I want to suspend X but not Y?', and if so how is it done? I
ask because someone recently mentioned the spinning up and down of IDE
during swsusp. That occurs because we can (AFAIK) only say suspend
everything at the moment. It would be good if we could put to sleep
everything except your system devices and the devices used to write the
image while preparing the image, and only suspend the remaining devices
once the image has been written. Is such a thing already implemented?

As an aside, I've gone to a 1.0 pre series for 2.4 swsusp, so it
shouldn't be long before I'm working on 2.5. I've already created
swsusp25.bkbits.net, but nothing is in it at the moment. My intention is
that as I prepare the patches and Pavel says 'That looks ok', I'll add
them to the tree and we can ask Linus to pull from there.

Regards,

Nigel

On Tue, 2003-06-10 at 10:04, Pavel Machek wrote:
> Hi!
> 
> > > Well, can you be a little more concrete? I do not see any description
> > > about what is system device and what is not.
> > > 
> > > Keyboard controller is very deeply integrated into the system. If it
> > > is not system device, what is it?
> > 
> > I apologize that the description of system devices is not in the driver 
> > model documentation. From the linux.conf.au paper:
> > 
> > System-level devices are devices that are integral to the routine
> > operation of the system. This includes devices such as processors,
> > interrupt controllers, and system timers. System devices do not follow
> > normal read/write semantics. Because of this, they are not typically
> > regarded as I/O devices, and are not represented in any standard
> > way. 
> 
> What about mtrr's? They seem like system-level devices to me. Still
> its usefull to have kmalloc in its suspend routine, which moves it to
> SAVE_STATE phase.
> 
> Decision on which level to put it is up to programmer, and it seems
> wrong to hardcode it into architecture. It may be more convient to do
> save stating at place where you still can kmalloc...
> 								Pavel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:15, NASB.


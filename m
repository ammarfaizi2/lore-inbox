Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTDWX7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTDWX7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:59:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50822 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264357AbTDWX7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:59:38 -0400
Date: Thu, 24 Apr 2003 01:11:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Werner Almesberger <wa@almesberger.net>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424001134.GD26806@mail.jlokier.co.uk>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570840000.1051136330@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I agree with both of you and propose a solution.

Martin J. Bligh wrote:
> > The kernel should pick a value that's safe in all cases. And
> > this is zero. Don't forget that there can be several seconds
> > between the driver's initialization and the moment when the
> > user-space utility gets to change the settings.
> 
> So if people want 0 volume for some reason, they can set *that*
> in userspace. Windows can manage to do this without cocking it up. 
> I don't see why we can't achieve it. 

The problem is that 1 second between loading the module and userspace
running a utility to restore the previous setting.  It can be <1
second, or quite long depending on how busy the machine is, swapping
etc.  Even a fraction of a second is unacceptable, though.

That loud feeback whistle sound in conference/at night is really
awful, and there was no way to avoid it with OSS on certain sound cards.

Even when the microphone is disabled, you still get (a) the sound of
nearby mobile phone radio signals (my laptop is very bad for this),
(b) a scary load "pop" as the sound system pulses the speaker.  This
is particularly bad with powered external speakers, as you wonder
whether it is good for them.

None of these sound effects when loading the module is necessary, so
ALSA is right to prevent them to the best of its ability.

However, Martin is right too - once the sound system is fully
initialised (including userspace), there should be a sensible default
volume.  And it would be nice, but is not necessary, if the sensible
default worked when you don't have a fancy userspace.

What is a sensible default?  On my laptop, again, even a low volume is
problemetic if there is nothing playing sounds, because it picks up
RFI from the laptop itself and from mobile phones.  (For this reason I
tend to leave the physical volume knob set low, which is confusing
when I do try to play something :)

Thus the nicest thing the drivers could do would be to keep the volume
at 0 when nothing is playing any sound, ramp it up to the desired
volume when a sound plays, and ramp it down after.  However that may be
asking a bit much of the sound driver authors.

So how about this:

   A standard audio module option "volume=X" meaning "set volume X%
   when the module initialises".

If unspecified, the default would be some quite but not silent value.
Err on the side of quiet because hardware varies so much.  Pick
whatever default Windows uses if possible :)

Then anything with a fancy enough userspace can set this to either (a)
zero, or (b) forget about user-space post-initialisation, just set the
correct value by passing it to the module at load time.

-- Jamie

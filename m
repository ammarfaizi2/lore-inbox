Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWHNPCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWHNPCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWHNPCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:02:52 -0400
Received: from aa003msr.fastwebnet.it ([85.18.95.66]:58054 "EHLO
	aa003msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751390AbWHNPCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:02:51 -0400
Date: Mon, 14 Aug 2006 16:58:48 +0200
From: Mattia Dongili <malattia@linux.it>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Magnus Vigerl???f <wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Message-ID: <20060814145848.GA4095@inferi.kami.home>
Mail-Followup-To: Dmitry Torokhov <dtor@insightbb.com>,
	Magnus Vigerl???f <wigge@bigfoot.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@suse.cz>
References: <200608121724.16119.wigge@bigfoot.com> <20060812165228.GA5255@aehallh.com> <200608122000.47904.dtor@insightbb.com> <20060813032821.GB5251@aehallh.com> <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.18-rc4-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Mon, Aug 14, 2006 at 10:20:09AM -0400, Dmitry Torokhov wrote:
[...]
> I've been thinking about all of this and all of it is very fragile and
> unwieldy and I am not sure that we really need another ioctl after
> all. The only issue we have right now is that mousedev delivers
> undesirable events through /dev/input/mice while there is better
> driver listening to /dev/input/eventX and they clash with each other.
> Still, /dev/input/mice is nice for dealing with hotplugging of simple
> USB mice. So can't we make mousedev only multiplex devices that are
> not opened directly (where directly is one of mouseX, jsX, tsX, or
> evdevX)? We could even control this behavior through a module
> parameter. Then noone (normally) would need to use EVIOCGRAB.

there's one more use case (don't know how much it's relevant but still
worth mentioning): pbbuttonsd v/s synaptics (x driver).

pbbuttonsd is a nice utility that (between the other things) monitors
keyboard and mouse activity and eventually sends the laptop to sleep.
The synaptics driver uses EVIOCGRAB and they don't work nice together
(eg: laptop goes to sleep even if actively using your touchpad)...

Now, with your proposal a user not using the synaptics driver and would
lose multiplexing to /dev/input/mice.

So why not just make EVIOCGRAB mean "don't send events to
mousedev but still report data to others opening the device"?

-- 
mattia
:wq!

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTI3U7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbTI3U7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:59:36 -0400
Received: from [195.249.40.37] ([195.249.40.37]:35596 "HELO nettonet.dk")
	by vger.kernel.org with SMTP id S261724AbTI3U71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:59:27 -0400
From: Simon Ask Ulsnes <simon@ulsnes.dk>
To: Matt Gibson <gothick@gothick.org.uk>
Subject: Re: Complaint: Wacom driver in 2.6
Date: Tue, 30 Sep 2003 22:59:26 +0200
User-Agent: KMail/1.5.4
References: <200309291421.45692.simon@ulsnes.dk> <200309300859.23281.simon@ulsnes.dk> <200309301813.03609.gothick@gothick.org.uk>
In-Reply-To: <200309301813.03609.gothick@gothick.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309302259.26652.simon@ulsnes.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exactly. Of course I never have both the IMPS/2 protocol driver and the Wacom 
driver enabled at the same time in XF86Config. The only difference between 
working and non-working is the kernel version. (i.e. it works perfectly with 
2.4 and not at all with 2.6).

One funny thing: I haven't got the mousedev module loaded at all, only evdev, 
hid and wacom.

You are right about the micro-bug about having to lift the mouse off the 
tablet for the wacom driver under 2.4 to be activated. That is standard 
behaviour, and has no effect with 2.6.

The reason I am not satisfied with things the way they are is that it feels 
like somehow the dimensions on the tablet don't fit with the screen. E.g., my 
mouse or pen might hit an edge on the tablet being several centimeters from 
the edge of the screen. And mouse (not pen) movement is absolute, it should 
be relative, which is a pain in a certain place.

The link you provided is outdated, the newest project is on 
linuxwacom.sourceforge.net. It seems strangely stalled, though.

Sincerely yours,
Simon Ask Ulsnes

On Tuesday 30 September 2003 19:13, you wrote:
> [disclaimer: I am not a kernel developer!]
>
> On Tuesday 30 Sep 2003 07:59, Simon Ask Ulsnes <simon@ulsnes.dk> wrote:
> > Thanks for replying.
> > You aren't even using the wacom driver!
>
> I _am_ using the wacom driver.  I'm just using the wacom kernel driver
> rather than the XFree86 wacom  driver.
>
> > Mine works too in that way (I think it is some kind of regular PS/2 mouse
> > emulation or so).
>
> I think it goes something like this: the kernel wacom driver now interprets
> wacom packets into standard kernel mouse input.  See drivers/usb/input/
> wacom.c for that: it's the wacom_graphire_irq() function that's doing it
> for us both.  Then /dev/mice gathers the input from all sources like this
> and presents them as a single ps/2-style mouse interface.  I _think_ this
> is done in mousedev.c, but I haven't really looked into it.  Someone feel
> free to correct me!
>
> On my machine, the result is that events from both my Wacom and my old PS/2
> style mouse are seamlessly merged into /dev/mice, so that's all X needs to
> consider, and I could use them both at once if I wanted.  Not that useful
> to me, in fact, and the PS/2 mouse is only connected for those rare
> occasions when I boot into some ancient program from a DOS floppy, but
> hey...
>
> I think, if you want to get the XFree86 driver working, you can't use /dev/
> mice as well (otherwise, for example, when using the pen,  your X mouse
> will get events from both /dev/mice, as the kernel translates the pen
> movements into /dev/mice events, _and_ from the Wacom driver interpreting
> the same input event stream.
>
> > Come to think of it, maybe the problem lies in the XFree86 driver, which
> > I suppose isn't really compatible with the new kernel. Well,
> > whatayaknow... ;-)
>
> I think that may be your problem.  I don't know whether the standard event
> interface has changed at all recently.  I haven't found any need for the
> extra tablet features yet that would need me to look into the XFree driver
> thoroughly (one thing I do remember, though, is that the last time I
> looked, you needed to remove the mouse from the pad and drop it back down
> again before the driver started working -- did you try that, or were you
> seeing weird results rather than no results at all?)
>
> Anyway.  It's quite possible that as 2.6 starts "getting about a bit", the
> XFree86 driver will be naturally updated to cope with it.  I don't know
> what the current status of the driver is.  The project homepage is here:
> http://people.mandrakesoft.com/~flepied/projects/wacom/ ...but I'm guessing
> you'd already found that.
>
> Good luck!
>
> M



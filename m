Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTIVGBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 02:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263004AbTIVGBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 02:01:46 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:40538 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262997AbTIVGBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 02:01:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Broken synaptics mouse..
Date: Mon, 22 Sep 2003 00:58:48 -0500
User-Agent: KMail/1.5.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <200309211816.36783.dtor_core@ameritech.net> <20030922053103.GA27045@ucw.cz>
In-Reply-To: <20030922053103.GA27045@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309220058.48015.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 12:31 am, Vojtech Pavlik wrote:
> On Sun, Sep 21, 2003 at 06:16:36PM -0500, Dmitry Torokhov wrote:
> > > You can use EVIOCGRAB for the time being in the XFree86 synaptics
> > > driver, this way you'll prevent its events coming into mousedev the
> > > moment it's opened by XFree86, which is probably exactly what one
> > > wants.
> >
> > Will that allow 2 processes to have access to the same event device
> > simultaneously? I am thinking about XFree and GPM. We just got away from
> > that mess caused by psaux providing only exclusive access to step into
> > the same problem again.
>
> No, it won't. Yes, it's a problem. The only solution I can propose here
> is when you want GPM and XFree support simultaneously you have to
> configure both to use either /dev/input/mice, or both /dev/input/event,
> and not mix the two together.
>

But in this case not only will I have to specify the event device Synaptics
is connected to but also explicitly specify _every other_ input device I use
(besides the touchpad I have a track-stick as a separate device and an USB
mouse in my docking station). I will also loose hot-plug capabilities I have 
now for free. 

All in all it just doesn't fly... I wonder if we could declare evdev the master
handler and do not propagate events to the secondary handlers if some process
has appropriate event device opened.

Dmitry

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTIUXQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 19:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTIUXQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 19:16:41 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:45640 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262598AbTIUXQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 19:16:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>
Subject: Re: Broken synaptics mouse..
Date: Sun, 21 Sep 2003 18:16:36 -0500
User-Agent: KMail/1.5.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0309110744030.28410-100000@home.osdl.org> <m2fziqukhi.fsf@p4.localdomain> <20030921172758.GA21014@ucw.cz>
In-Reply-To: <20030921172758.GA21014@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309211816.36783.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 September 2003 12:27 pm, Vojtech Pavlik wrote:
> On Sun, Sep 21, 2003 at 07:20:09PM +0200, Peter Osterlund wrote:
> > > I'd really prefer to contain the ugliness in mousedev.c, which then
> > > could be removed completely in 2.8 or so, when XFree and GPM is already
> > > well adapted to the event interface.
> >
> > That's certainly possible too. See patch below. Note though that this
> > patch has the disadvantage mentioned by Dmitry:
> >
> >         We also can't just emulate relative events as everything is
> >         multiplexed into /dev/input/mice and I can see many people
> >         using Synaptics via /dev/input/eventX and everything else via
> >         /dev/input/mice as it nicely handles hot plugging (at least I
> >         use it this way).
>
> You can use EVIOCGRAB for the time being in the XFree86 synaptics
> driver, this way you'll prevent its events coming into mousedev the
> moment it's opened by XFree86, which is probably exactly what one wants.
>

Will that allow 2 processes to have access to the same event device 
simultaneously? I am thinking about XFree and GPM. We just got away from
that mess caused by psaux providing only exclusive access to step into
the same problem again.

Dmitry 

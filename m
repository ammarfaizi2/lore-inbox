Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTITLiW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbTITLiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:38:22 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:959 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261850AbTITLiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:38:15 -0400
Date: Sat, 20 Sep 2003 13:38:03 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitri Katchalov <dmitrik@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.6.0-test5 atkbd.c: Unknown key (100% reproduceable)
Message-ID: <20030920113803.GA8779@ucw.cz>
References: <1063443074.3f62da82a7e24@webmail.netregistry.net> <20030913220743.B3295@pclin040.win.tue.nl> <1063527169.3f642301c00e7@webmail.netregistry.net> <20030914185142.F3371@pclin040.win.tue.nl> <003c01c37b8f$9e09fba0$0a01a8c0@internal.dimasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003c01c37b8f$9e09fba0$0a01a8c0@internal.dimasoftware.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 11:45:25PM +1000, Dmitri Katchalov wrote:
> > On Sun, Sep 14, 2003 at 06:12:49PM +1000, Dmitri Katchalov wrote:
> > > Quoting Andries Brouwer <aebr@win.tue.nl>:
> >
> > > > On Sat, Sep 13, 2003 at 06:51:14PM +1000, Dmitri Katchalov wrote:
> > > >
> > > > > I'm consistently getting this error:
> > > > >
> > > > > atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0)
> pressed.
> > > > > This happens whenever I type 'f' in "<F7>usbdevfs".
> >
> > It seems most likely that this keyboard is broken.
> > Instead of 0xa1 (f release) you get 0xab (\ release).
> > By some coincidence 0xab is f release in untranslated scancode set 2.
> > (But you are in translated scancode set 2, otherwise the other letters
> > would also have produced different codes.)
> >
> > Could you try to run "showkey -s" on the console under 2.4.*?
> > Hit and release the f a few times. Type <F7>usbdevfs.
> >
> > Just a broken key is something I have seen lots of times.
> > Since for most operating systems make codes are important
> > while break codes (other than those for Shift, Ctrl, Alt)
> > are not, a key with broken release code is usually harmless.
> >
> > This case seems interesting because, if I understand you correctly,
> > the f in itself is not always broken, but this error occurs after
> > a particular sequence of keystrokes.
> 
> I've just run showkey. This is WEIRD! I've never seen anything
> like it (almost)! It is definitely a bug in my keyboard.
> Whenever 'f' occurs in the stream exactly 12 scancodes
> after <F7> it reports wrong release code. It even has a "queue"
> so that multiple instances of the bug can be pipelined :)

Interesting. Can you check if it goes away with a different keyboard?
How about when you disable ACPI?

> Interestingly the bug has no ill effects on 2.4.18 at all. It just works.
> In 2.6.0-test5 I'm getting a message right across the screen followed
> by zillions of 'f's.
> 
> Andries, thanks for your time and for the hints you gave me. I'll put a
> workaround in my kernel. I don't think it will be useful to anyone else
> though:)

Next available 2.6 should have that worked around.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

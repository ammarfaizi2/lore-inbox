Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTIONrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 09:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbTIONq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 09:46:59 -0400
Received: from mta03bw.bigpond.com ([144.135.24.147]:19451 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP id S261352AbTIONqz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 09:46:55 -0400
Date: Mon, 15 Sep 2003 23:45:25 +1000
From: Dmitri Katchalov <dmitrik@users.sourceforge.net>
Subject: Re: 2.6.0-test5 atkbd.c: Unknown key (100% reproduceable)
To: linux-kernel@vger.kernel.org
Cc: Andries Brouwer <aebr@win.tue.nl>
Message-id: <003c01c37b8f$9e09fba0$0a01a8c0@internal.dimasoftware.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <1063443074.3f62da82a7e24@webmail.netregistry.net>
 <20030913220743.B3295@pclin040.win.tue.nl>
 <1063527169.3f642301c00e7@webmail.netregistry.net>
 <20030914185142.F3371@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Sep 14, 2003 at 06:12:49PM +1000, Dmitri Katchalov wrote:
> > Quoting Andries Brouwer <aebr@win.tue.nl>:
>
> > > On Sat, Sep 13, 2003 at 06:51:14PM +1000, Dmitri Katchalov wrote:
> > >
> > > > I'm consistently getting this error:
> > > >
> > > > atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0)
pressed.
> > > > This happens whenever I type 'f' in "<F7>usbdevfs".
>
> It seems most likely that this keyboard is broken.
> Instead of 0xa1 (f release) you get 0xab (\ release).
> By some coincidence 0xab is f release in untranslated scancode set 2.
> (But you are in translated scancode set 2, otherwise the other letters
> would also have produced different codes.)
>
> Could you try to run "showkey -s" on the console under 2.4.*?
> Hit and release the f a few times. Type <F7>usbdevfs.
>
> Just a broken key is something I have seen lots of times.
> Since for most operating systems make codes are important
> while break codes (other than those for Shift, Ctrl, Alt)
> are not, a key with broken release code is usually harmless.
>
> This case seems interesting because, if I understand you correctly,
> the f in itself is not always broken, but this error occurs after
> a particular sequence of keystrokes.

I've just run showkey. This is WEIRD! I've never seen anything
like it (almost)! It is definitely a bug in my keyboard.
Whenever 'f' occurs in the stream exactly 12 scancodes
after <F7> it reports wrong release code. It even has a "queue"
so that multiple instances of the bug can be pipelined :)

Interestingly the bug has no ill effects on 2.4.18 at all. It just works.
In 2.6.0-test5 I'm getting a message right across the screen followed
by zillions of 'f's.

Andries, thanks for your time and for the hints you gave me. I'll put a
workaround in my kernel. I don't think it will be useful to anyone else
though:)

Regards,
Dmitri


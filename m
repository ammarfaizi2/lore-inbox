Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932644AbWBTFuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644AbWBTFuJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWBTFuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:50:08 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:11434 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932644AbWBTFuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:50:07 -0500
From: David Brownell <david-b@pacbell.net>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Sun, 19 Feb 2006 21:50:05 -0800
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <200602131116.41964.david-b@pacbell.net> <200602181251.09865.david-b@pacbell.net> <43F80ACC.20704@cfl.rr.com>
In-Reply-To: <43F80ACC.20704@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602192150.05567.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 10:06 pm, Phillip Susi wrote:
> David Brownell wrote:
> > 
> > Hardware is CORRECTLY reporting electrical disconnects,
> > but Philip is wanting Linux to ignore those reports.
> 
> No, not ignore, just realize that an electrical disconnection does not 
> necessarily mean that the volume can no longer be accessed.

Exactly:  ignore those disconnects in "some" cases.  Suspend-to-RAM
will typically never report disconnects without a real unplug.  You
want to add special casing for hibernate/swsusp.  (A point in favor
of someone's claim that hibernate/swsusp is structurally harder.)


Now with /dev/input/mice, the driver stack above USB is able to mask
such disconnects.  It's not like mice maintain state that matters.
The "ignore" is in stack layers way above USB, which can know a very
important thing about mice:  they are stateless.

But with storage media, there is no such mechanism ... and there's
significant state involved.  Adding a "reconnect" mechanism, and
getting it wrong for storage, likely means corrupted file systems.
And where even if it _is_ the same physical disk, there's no good
reason to expect it hasn't been modified on some other usb host.
(Toss hardware in bag, reuse as needed...)

No thanks, I prefer data integrity.  And for that matter, re $SUBJECT,
the much simpler approach of working _with_ the hardware architecture,
not against it.


> > But yes, you're right ... if he's serious about
> > changing all that stuff, he also needs stop being a
> > member of the "never submitted a USB patch" club.
> > Ideally, starting with small things.
> 
> You're moving off into left field.

Not hardly.  Unless all you're doing here is flaming?
One point of $SUBJECT was that flames were _over_ ...


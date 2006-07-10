Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWGJSNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWGJSNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWGJSNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:13:19 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:9484 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S965199AbWGJSNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:13:19 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Date: Mon, 10 Jul 2006 19:13:45 +0100
User-Agent: KMail/1.9.3
Cc: Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com> <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com> <44B26752.9000507@gmail.com>
In-Reply-To: <44B26752.9000507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101913.45070.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 15:42, Antonino A. Daplas wrote:
> Jon Smirl wrote:
> > On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >> Ar Llu, 2006-07-10 am 09:03 -0400, ysgrifennodd Jon Smirl:
> >> > I agree with this. I made a mistake with the pts vs pty, why not just
> >> > help me fix the mistake instead of rejecting everything? Some the of
> >> > the info being reported in /proc/tty/drivers is wrong (vc./0 - from
> >> > the devfs attempt?). or missing.
> >>
> >> What are you trying to achieve and where are you trying to get. If you
> >> want better info for the tty layer then get the new info working in
> >> sysfs first. Then when people are generally using sysfs you can worry
> >> about cleaning up/removing/breaking the old stuff.
> >
> > Before the change /proc/tty/drivers shows this:
> >
> > [jonsmirl@jonsmirl ~]$ cat /proc/tty/drivers
> > /dev/tty             /dev/tty        5       0 system:/dev/tty
> > /dev/console         /dev/console    5       1 system:console
> > /dev/ptmx            /dev/ptmx       5       2 system
> > /dev/vc/0            /dev/vc/0       4       0 system:vtmaster
>
> vtmaster was /dev/tty0 in 2.2.x, changed to /dev/vc/0 probably
> because of devfs. I would tend to agree with the change of at least
> this part.
>
> A few apps do rely on /proc/tty/drivers for the major-minor
> to device name mapping. /dev/vc/0 does not exist (unless
> created manually) without devfs.

Create a file in /etc/udev/rules.d. Add to it the following.

# devfs-ify vt devices
KERNEL="tty[0-9]*",  NAME="vc/%n"

Now John's names are broken.

As Alan's wisely pointed out, it's utterly insane to try to "fix" a legacy 
file when it a) can never match all possible, legal, current configurations 
and b) shouldn't be used for anything important anyway.

It'd be better to CONFIG out this directory and see what breaks. Then we can 
decide if we should (or provide distributors the option to) remove it.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

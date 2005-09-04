Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVIDQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVIDQyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 12:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVIDQyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 12:54:47 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:34733 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750961AbVIDQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 12:54:46 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 17:54:54 +0100
User-Agent: KMail/1.8.90
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
References: <NBBBIHMOBLOHKCGIMJMDGEHPEKAA.g.tomassoni@libero.it> <200509041720.55588.s0348365@sms.ed.ac.uk> <Pine.LNX.4.63.0509041830270.29195@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0509041830270.29195@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041754.54995.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 17:41, Grzegorz Kulewski wrote:
> On Sun, 4 Sep 2005, Alistair John Strachan wrote:
> > On Sunday 04 September 2005 12:05, Giampaolo Tomassoni wrote:
> >> Dears,
> >>
> >> thanks to Jiri Slaby who found a bug in the AAL0 handling of the ATMSAR
> >> module.
> >>
> >> I attach a fixed version of the atmsar patch as a diff against the
> >> 2.6.13 kernel tree.
> >
> > [snip]
> >
> > Just out of curiosity, is there ANY reason why this has to be done in the
> > kernel? The PPPoATM module for pppd implements (via linux-atm) a
> > completely userspace ATM decoder.. if anything, now redundant ATM stack
> > code should be REMOVED from Linux!
> >
> > Most distributions (to my knowledge) supporting the speedtouch modem do
> > so using the method prescribed on speedtouch.sf.net; an entirely
> > userspace procedure. pppd does all the ATM magic.
> >
> > Does this have real-world applications beyond the Speedtouch DSL modems?
> > If not, I propose adding this code to linux-atm, not the kernel, since
> > most users of USB speedtouch DSL modems will not be using the kernel's
> > ATM.
>
> I am using SpeedTouch 330 modem with kernel driver (on Gentoo).
>
> The instalation is currently (with firmware loader instead of modem_run)
> very simple: USE="atm" emerge ppp, download firmware and place it in
> /lib/firmware, compile the kernel with speedtch support.

Compared to "place the firmware in /lib/firmware" on many other distros, this 
sounds like a lot of work! The kernel speedtch provides no advantages to its 
userspace alternative.

> I tried to use userspace driver some time ago but it wasn't working for me
> so I gave up. I was using modem_run with kernel driver for long time to
> load the firmware but there were many problems with it too (nearly every
> kernel or modem_run upgrade was breaking something, modem_run was hanging
> in D state in most unapropriate moments and so on).

This is not the case any longer.

> Now I am using pure kernel driver and firmware loader and it works 100%
> ok. There were no problems with it for long time. And I don't even want to
> look at this userspace driver again.

Conversely people (including myself) found the kernel implementation to be 
buggy, and when userspace breaks, you can simply restart it.. when the kernel 
breaks, you have to reboot.

> Since Linux newer was (or is going to be) userspace-driver OS, maybe we
> should leave it that way...

No.

What can be done in userspace, within valid performance constraints, usually 
should be. This has always been the Linux kernel way.

The speedtouch modem is a USB device, and there are many existing userspace 
"driver" implementations for USB devices. Including speedtouch.

I'm not necessarily saying this code shouldn't be in the kernel, I'd just be 
interested to know why it has to be.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

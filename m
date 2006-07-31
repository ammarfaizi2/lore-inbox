Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWGaXJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWGaXJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWGaXJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:09:16 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:3474 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751454AbWGaXJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:09:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Date: Tue, 1 Aug 2006 01:08:21 +0200
User-Agent: KMail/1.9.3
Cc: "'Pavel Machek'" <pavel@ucw.cz>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <005101c6b4d2$f7506210$493d010a@nuitysystems.com>
In-Reply-To: <005101c6b4d2$f7506210$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608010108.22073.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 20:55, Hua Zhong wrote:
]--snip--[
> > He claims s-t-ram is easier than s-t-disk. That means that he did not do his 
> > homework, and did not check the archives on the subject.
> 
> Oh yeah? Let's check the archives:
> 
> "I seriously claim that STR _should_ be a lot simpler than suspend-to-disk, 
> because it avoids all the memory management problems. The reason that 
> we support suspend-to-disk but not STR is totally perverse - it's simply that
> it has been easier to debug, because unlike STR, we can do a "real boot" 
> into a working system, and thus we don't have the debugging problems that
> the "easy" suspend/resume case has."
> 
> http://thread.gmane.org/gmane.linux.power-management.general/1884/focus=2105

The "_should_" is important here, IMHO.

I think the problems that we have with getting STR to work on many machines
reflect the situation in which we are with respect to the hardware.  From the
programming point of view it's easy, because if you know how to handle the
hardware, it doesn't take a lot to get it right.  Still, you need to _know_,
and we're talking of things that are hardly documented and require hours of
trial-and-error to figure out.  Usually, it can only be done by someone who
(a) has access to the hardware in question, (b) has a lot of time, (c)  is
_very_ determined to make the suspend and resume work on this particular
 device, because these things are notoriously difficult to debug,  and (d),
ideally, knows how to write Linux device drivers.  If you own an "exotic"
notebook, there's practically no chance to find someone like that who owns
one too.

Moreover, even if there are some hardware-related fixes in the wild, we can't
just throw them at Andrew to merge, because some kernel developers may
think they are not the right fixes.  Each fix, before it gets merged, if ever,
has to be reviewed by the appropriate driver maintainers and people who know
how the related subsystems work.  If the fix gets rejected, we can't help it.

For example, we've recently received a fix for a resume-related problem
on some IDE chipsets (AMD and NVidia ones), but it has been vetoed by
Alan Cox.  The Alan's arguments are reasonable and everyone seems to agree
that it should be done differently, but the net result, for now, is the
problem remains - officially - unfixed (see
http://www.ussg.iu.edu/hypermail/linux/kernel/0607.3/1607.html).

However, Nigel maintains his patch in separation with the mainline kernel
and he can include fixes like that into it just fine.  He can include whatever
he likes, as long as it works, but we just can't do that.  You can say he has
more freedom, because he doesn't have to take the other people's opinions
into consideration, so he can make suspend2 work on a greater number of
systems more easily.  Yet, he faces the other people's opinions about the
things that are in suspend2 whenever he submits it for merging.  In other
words, the same things that make suspend2 work on machines on which
swsusp doesn't may also render it _very_ difficult to merge (eg. if Nigel had
decided to include the patch vetoed by Alan into suspend2, the Alan's NAK
would have applied to suspend2 as a whole).

Generally speaking suspend2 is a collection of many different solutions, some
of them being more or less questionable, in many different areas which should
not be considered all at once.  There should be a separate patch for each of
them, submitted and discussed on its own.  Moreover,  some of these solutions
may be considered as not the right ones and some patches may get rejected,
which may affect the next patches etc.  Still, this is the way in which the
kernel is developed and we have no other way to follow.

Greetings,
Rafael

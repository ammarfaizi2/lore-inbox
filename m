Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752274AbWKBTM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbWKBTM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbWKBTM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 14:12:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752262AbWKBTM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 14:12:26 -0500
Subject: Re: [airo.c bug] Couldn't allocate RX FID / Max tries exceeded
	when issueing command
From: Dan Williams <dcbw@redhat.com>
To: Ivan Matveich <ivan.matveich@gmail.com>
Cc: linux-kernel@vger.kernel.org, linville@tuxdriver.com,
       netdev@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net, jt@hpl.hp.com, fabrice@bellet.info
In-Reply-To: <b5def3a40611021030s1b73daa1k2055e5f4373fa746@mail.gmail.com>
References: <b5def3a40611011914v59ecd4c3xb6965591524aa11@mail.gmail.com>
	 <1162483971.2646.9.camel@localhost.localdomain>
	 <b5def3a40611021030s1b73daa1k2055e5f4373fa746@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 14:11:19 -0500
Message-Id: <1162494679.3347.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 13:30 -0500, Ivan Matveich wrote:
> On 11/2/06, Dan Williams <dcbw@redhat.com> wrote:
> > It appears that the driver cannot talk to your card; see the "max tries
> > exceeded when issueing command".  Did this card work previously with a
> > kernel?  Can narrow down which kernels have problems and which don't?
> 
> It spontaneously stopped working about a week after I bought the

That does not bode well for the card itself.

> laptop and installed Linux. I tried kernel 2.6.12 and it had the same
> problem. (Let me know if you'd like me to try a specific version.)

2.6.12 should be old enough, but maybe if you could try 2.6.9 that would
definitely be old enough to rule out recent airo changes.

> I'm hoping that the card has simply got itself into some kind of
> invalid state, and not failed altogether.
> 
> > It's a bit hard to figure out what firmware you have because the driver
> > can't talk to the card; can you boot under Windows and determine that
> > using the Cisco wireless utility?  You also need to flash the card under
> > Windows, not Linux, ideally to a version of firmware greater than
> > 5.60.08.
> 
> I haven't run Windows in many years, so that's problematic. What's the
> most straightforward way to boot into a Windows environment sufficient
> to run the Cisco wireless utility?

You get to either install windows on your laptop, or pull the card
(pcmcia or minipci, either way) and put it into a windows computer.

> > reloading the driver (rmmod airo; modprobe airo) should reset the card.
> 
> Yeah, it unfortunately doesn't help. (Nor does rebooting or resetting
> the bios.) I noticed a suspiciously relevant commit in the airo.c git
> log:
> 
>     [wireless airo] reset card in init
> 
>     without this patch after an rmmod, modprobe the card won't work anymore
>     until the next reboot.
> 
>     This patch seem safe to apply for all cards as the bsd driver already do
>     that.
> 
>     I had to add a timeout because strange things happen (issuecommand will
>     fail) if the card is already reseted (after a reboot).
> 
>     PS : it seems there are missing reset when leaving monitor mode...
> 
>     Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

Do you know which kernel version that patch first appeared in?

> and that makes me wonder if there might be some kind of subtle bug in
> the card initialization sequence that manifests itself with my
> particular card/firmware.

Could be, it would be quite helpful to get the version of firmware you
are using.  Versions earlier than 5.30.17 are known not be flaky or even
not work with newer Linux kernel drivers since Cisco changed the
firmware interface in that version.  That said, I've seen cards in the
5.00.xx range work with the latest drivers, but not well.  These older
firmware versions sometimes lock up sponaneously and require a reboot,
updating to later firmware post-5.30.17 fixes that problem.

> I think I'll burn a freebsd livecd today and see if their kernel works.

That would be a great idea, let us know what the results are, especially
if you cna figure out which firmware version you have, or if the card
itself is really just dead.

Thanks,
Dan


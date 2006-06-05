Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751254AbWFESHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWFESHP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWFESHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 14:07:15 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:429 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751254AbWFESHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 14:07:13 -0400
From: David Brownell <david-b@pacbell.net>
Subject: Fwd: [linux-pm] [patch/rft 2.6.17-rc5-git 0/6] PM_EVENT_PRETHAW
Date: Mon, 5 Jun 2006 11:07:08 -0700
User-Agent: KMail/1.7.1
To: linux-usb-devel@lists.sourceforge.net,
        Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051107.09213.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary message below; see everything at these URLs, if interested:

[0] http://lists.osdl.org/pipermail/linux-pm/2006-June/002448.html
[1] http://lists.osdl.org/pipermail/linux-pm/2006-June/002444.html
[2] http://lists.osdl.org/pipermail/linux-pm/2006-June/002446.html
[3] http://lists.osdl.org/pipermail/linux-pm/2006-June/002447.html
[4] http://lists.osdl.org/pipermail/linux-pm/2006-June/002443.html
[5] http://lists.osdl.org/pipermail/linux-pm/2006-June/002445.html
[6] http://lists.osdl.org/pipermail/linux-pm/2006-June/002442.html

----------  Forwarded Message  ----------

Subject: [linux-pm] [patch/rft 2.6.17-rc5-git 0/6] PM_EVENT_PRETHAW
Date: Monday 05 June 2006 9:36 am
From: David Brownell <david-b@pacbell.net>
To: linux-pm@lists.osdl.org

Following this message will be patches adding the new PRETHAW event,
so that drivers can make sure that swsusp doesn't put hardware into
bogus states before resuming.

As previously discussed, this is needed by drivers which examine the
hardware state during resume() methods ... notably, USB controller
drivers, which expect to see true suspend states in order to handle
remote wakeup, but currently break with swsusp.  Only two states are
valid in resume():  after hardware reset, or else the state that
suspend() left it in.  PRETHAW allows drivers to force the former.

In sequence, the patches are:

 - prethaw-misc.patch ... fixes code that's currently broken/dubious
   so that it won't care about the new message (and is thus more or
   less mergeable regardless of the rest of these patches)

 - prethaw-header.patch ... defines the new event and its message

 - prethaw-fw.patch ... IDE and (dumb) PCI can handle it simplistically

 - prethaw-video.patch ... likewise, but this is per-driver not at the
   framework level

 - prethaw-usb.patch ... fixing various "swsusp resume fails if the
   HCD is statically linked" bugs

 - prethaw-core.patch ... updating the pm core to issue PRETHAW
   events, handling for which which the previous patches added.

Yes, it might be worth splitting some of those driver patches out into
patch-per-driver format.  Yes, I _did_ look at a couple hundred drivers
(grr) to see what needed changing ... darn few drivers treat suspend() as
anything other than PM_EVENT_SUSPEND.

- Dave

_______________________________________________
linux-pm mailing list
linux-pm@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/linux-pm


-------------------------------------------------------

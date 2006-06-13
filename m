Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWFMRSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWFMRSK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 13:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFMRSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 13:18:10 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:6539 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932197AbWFMRSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 13:18:09 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [linux-pm] Remote wake up not working
Date: Tue, 13 Jun 2006 10:17:58 -0700
User-Agent: KMail/1.7.1
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>,
       rasmit.ranjan@wipro.com
References: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com> <20060610132832.GB4547@ucw.cz> <1150215167.6305.6.camel@johannes>
In-Reply-To: <1150215167.6305.6.camel@johannes>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131018.00575.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 9:12 am, Johannes Berg wrote:
> On Sat, 2006-06-10 at 13:28 +0000, Pavel Machek wrote:
> 
> > I do not think we support remote wakeup these days. Code may be there,
> > but as noone ever uses it... perhaps it needs some fixing.
> 
> Works fine with bluetooth on my powerbook, but then again, I can't turn
> it *off* which is rather annoying, but I think caused by the missing
> suspend/resume handlers in hci_usb :/

USB remote wakeup basically works today (given CONFIG_USB_SUSPEND),
and has worked for quite a few kernel releases now, given

  (a) Working platform support.  So for example ACPI will not-infrequently
      do the wrong thing on resume, or the video driver misbehaves, and
      so on.  All too few systems work correctly with either (a1) "standby"
      or (a2) "mem" when you write them to /sys/power/state, and the issues
      have only rarely been related to USB.  (I got some mail over the last
      few days about one that boiled down to interrupt controller bugs.)

  (b) Support in the USB drivers for suspend/resume.  I've seen other
      reports lately about hci_usb is missing usb suspend/resume calls,
      leading to misbehavior.  (I think someone checked in an odd patch
      a while ago which change the failure mode for those missing calls
      to something that was still broken, just not as obviously.)  And
      then there are the ALSA drivers, and quite a few others...

That's not to say that it's perfect -- the clock framework is still missing
a hook to help embedded USB hosts behave right, and the /proc/acpi/wakeup
state isn't even vaguely integrated with the driver model wakeup stuff -- but
there are no known blocking issues there inside the USB stack or the main
host controller drivers.

- Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTKCV0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTKCV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:26:05 -0500
Received: from palrel11.hp.com ([156.153.255.246]:37013 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262796AbTKCV0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:26:02 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16294.51171.463585.783228@napali.hpl.hp.com>
Date: Mon, 3 Nov 2003 13:25:55 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <3FA5CF9E.2060507@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<3FA5CF9E.2060507@pacbell.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 02 Nov 2003 19:46:38 -0800, David Brownell <david-b@pacbell.net> said:

  David> I'm not sure that if the HID driver were to pass a null
  David> buffer pointer, it would be caught anywhere.
  >>  OK, I'll try to find some time to trace the I/O MMU calls to see
  >> if something isn't kosher at that level.  Is there a good way of
  >> getting a relatively high-level of tracing in the USB subsystem
  >> that would some me what's going on between the HID and the core
  >> USB level?

  Dave.B> Most of that story is just submitting and completing URBs.

Yeah.  And it appears that it's the very first call to
hid_submit_ctrl() that's triggering the problem (not always, but about
9 out of 10 times).  I dumped some of the key fields for the URB being
submitted and they all looked saned to me.

  Dave.B> I'd either try changing the spots in drivers/usb/core/hcd.c
  Dave.B> marked as appropriate for generic MONITOR_URB hooks (printk
  Dave.B> if it's your HID device, maybe), or manually turn on
  Dave.B> whatever HCD-specific hooks exist (maybe use a VERBOSE
  Dave.B> message level).

OK, thanks for the suggestion.  I'll keep looking, but will be on
travel this week, so I may not be able to spend much time on this
problem.

	--david

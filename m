Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbVBDUvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbVBDUvC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbVBDUon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:44:43 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:37548 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S266043AbVBDUlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:41:36 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
Date: Fri, 4 Feb 2005 12:41:27 -0800
User-Agent: KMail/1.7.1
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
References: <1107519382.1703.7.camel@localhost.localdomain>
In-Reply-To: <1107519382.1703.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200502041241.28029.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 4:16 am, Rusty Russell wrote:
> 
> Is USB/SCSI just terminally broken under 2.6?  

I don't think so, but there are problems that appear in some
hardware configs and not others.  Many folk report no problems;
a (very) few report nothing but.

If you've verified this on 2.6.10, then you certainly have
have the ehci-hcd (re)queueing race fix that has made a big
difference for some folk.  I don't know of any other issues
in that driver that could explain usb-storage problems.

What hardware config do you have?

  - Whose EHCI controller and revision?  I've never had
    good luck with VIA VT6202.  ("lspci -v".)

  - Whose USB storage adapter?  ("lsusb -v", or in this
    case the /proc/bus/usb/devices entry would be ok.)
    GeneSys adapters have been the most problematic,
    but they're hardly the only ones with quirks.

Thing is, that driver stack isn't especially thin:  SCSI isn't
the top, and it's got usb-storage, usbcore, and a USB HCD under
it.  That makes it harder to track down root causes, even when
there is just a single one and it's in those drivers (rather
than being hardware misbehavior).

- Dave

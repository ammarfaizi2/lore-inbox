Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTLJQ6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTLJQ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:58:12 -0500
Received: from mail1.kontent.de ([81.88.34.36]:60817 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263763AbTLJQ6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:58:08 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Wed, 10 Dec 2003 17:58:02 +0100
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312101720.22731.oliver@neukum.org> <200312101749.17173.baldrick@free.fr>
In-Reply-To: <200312101749.17173.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312101758.02334.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Dezember 2003 17:49 schrieb Duncan Sands:
> On Wednesday 10 December 2003 17:20, Oliver Neukum wrote:
> > Am Mittwoch, 10. Dezember 2003 14:22 schrieb Duncan Sands:
> > > > That leads to the question of how to assure that the device doesn't go
> > > > away before usb_set_configuration is called.  Perhaps
> > > > usb_set_configuration and usb_unbind_interface should be changed to
> > > > require the caller to hold the serialize lock.
> > >
> > > How about
> > >
> > > __usb_set_configuration - lockless version
> > > usb_set_configuration - locked version
> >
> > Partially done.
> > That's what the _physical version of usb_reset_device() is about.
> 
> Unfortunately, usb_physical_reset_device calls usb_set_configuration
> which takes dev->serialize.

That is bad, but the solution is obvious.
All such operations need a _physical version.
At first sight this may look less elegant than some lock dropping schemes,
but it is a solution that produces obviously correct code paths with respect
to locking.

	Regards
		Oliver


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVCOUoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVCOUoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVCOUlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:41:12 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:22912 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261640AbVCOUiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:38:13 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net, dtor_core@ameritech.net
Subject: Re: [linux-usb-devel] Re: [RFC] Changes to the driver model class code.
Date: Tue, 15 Mar 2005 12:35:02 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
References: <20050315170834.GA25475@kroah.com> <20050315195121.GA27408@kroah.com> <d120d50005031512143929e39f@mail.gmail.com>
In-Reply-To: <d120d50005031512143929e39f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503151235.02934.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 March 2005 12:14 pm, Dmitry Torokhov wrote:
> 
> It looks to me (and I might be wrong) that USB was never really
> integrated into the driver model. It was glued with it but the driver
> model came after most of the domain was defined, and it did not get to
> be "bones" of the subsystem. This is why it is so easy to deatch it.

That doesn't seem accurate to me.  Are you thinking maybe about
just how it uses the class device stuff?  Like the rest of the
class device support (for all busses!) that did indeed come later.
You may recall that the first versions of the driver model had
more or less a big "fixme" where class devices sat...  Or are
you maybe thinking about peripheral side (not host side) USB?

But the "struct device" core of the driver model sure looks like
the bones of USB to me.  Host controllers, hubs, devices, and
interfaces all use it well, behave well with hot-unplug (which
is more than many subsystems can say even in 2.6.11!), and even
handling funky cases like drivers needing to bind to multiple
interfaces on one device.  That last took quite a while to land,
it involved ripping out the last pre-driver-model binding code.

I would really _not_ want to try to detach any of that stuff!

- Dave
 



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbULTHtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbULTHtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbULTHqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:46:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261468AbULTGbT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:31:19 -0500
Date: Sun, 19 Dec 2004 22:30:06 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041219223006.4301bb8c@lembas.zaitcev.lan>
In-Reply-To: <41C65EA0.7020805@osdl.org>
References: <20041220001644.GI21288@stusta.de>
	<20041220003146.GB11358@kroah.com>
	<20041220013542.GK21288@stusta.de>
	<20041219205104.5054a156@lembas.zaitcev.lan>
	<41C65EA0.7020805@osdl.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004 21:09:52 -0800, "Randy.Dunlap" <rddunlap@osdl.org> wrote:

> Pete Zaitcev wrote:
> > On Mon, 20 Dec 2004 02:35:42 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > 
> >>What about a dependency of BLK_DEV_UB on USB_STORAGE=n ?
> > 
> > I have them both as 'm' in my configuration, works like a charm.
> 
> ub can work like that, but it makes it darned difficult to
> use usb-storage like that.  ub wants to bind to the devices,
> not usb-storage, and if ub is unloaded, usb-storage doesn't
> bind to them.  at least that's been my experience with it.

There is no asymmetry in lists of devices in either of them, however
currently there aren't any devices which usb-storage cannot handle
and ub can. Thus it makes sense to conditionalize part of usb-storage
list on ub. Otherwise, it would be a separate configuration item,
I suppose. We'll when we get there.

I don't quite understand why it matters for you if a certain module
is loaded or not loaded. The hotplug acts upon the contents of
modules.usbmap which does not change when you modprobe or rmmod things.
So, the match lists are made non-conflicting between
ub and usb-storage. It looks as if Adrian has the same broken mental
model of the way things work. Once again, what is loaded does not
matter (not in ideal world, but in reality we still have conflicts such
as e100 and eepro100).

-- Pete

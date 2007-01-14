Return-Path: <linux-kernel-owner+w=401wt.eu-S1750860AbXANAgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbXANAgG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbXANAgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:36:06 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:62652 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbXANAgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:36:05 -0500
Subject: Re: No more "device" symlinks for classes
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45A9797F.9000806@drzeus.cx>
References: <45A97089.5090004@drzeus.cx>
	 <1168732961.14924.39.camel@pim.off.vrfy.org>  <45A9797F.9000806@drzeus.cx>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 01:35:51 +0100
Message-Id: <1168734951.14924.50.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 01:29 +0100, Pierre Ossman wrote:
> Kay Sievers wrote:
> >
> > The plan is to have a single unified tree at /sys/devices, where all
> > device-directories live below their parents, and /sys/class contains
> > only symlinks pointing into this single tree, just like /sys/bus.
> >
> > People want to stack class-devices, but this leads to a /sys/devices
> > tree and several small trees spread around in /sys/class. These trees
> > need to be connected by "device"-links and the "class:"-links, which
> > just doesn't make much sense if you can have one single tree with the
> > same information.
> >
> > In the unified tree, the "device"-link will always just point to the
> > parent device, that's why there is a config option to disable these
> > links and test current software not to depend on it.
> >
> I'm not sure I completely follow. Should an application look at the
> symlink (e.g. /sys/class/fooclass/foodev -> /sys/devices/...) and follow
> that one level up? If so, then this sounds a bit complicated. Especially
> from shell scripts.

We would have one single tree at /sys/devices, and always flat
classification without hierarchy at /sys/class and /sys/bus. If you
enter the device-tree by starting at /sys/class, you get the full path
to the device by reading the link, and get all the device's
dependencies(parents) in the devpath of the device,

I can't see any problem stripping the last element of a path with a
shell script. It's all implemented in current udev and HAL for quite
some time and it's pretty easy.

Kay


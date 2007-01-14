Return-Path: <linux-kernel-owner+w=401wt.eu-S1751399AbXANACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbXANACv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXANACv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 19:02:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:59180 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbXANACv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 19:02:51 -0500
Subject: Re: No more "device" symlinks for classes
From: Kay Sievers <kay.sievers@vrfy.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45A97089.5090004@drzeus.cx>
References: <45A97089.5090004@drzeus.cx>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 01:02:41 +0100
Message-Id: <1168732961.14924.39.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 00:51 +0100, Pierre Ossman wrote:
> I just wanted to know the rationale behind
> 99ef3ef8d5f2f5b5312627127ad63df27c0d0d05 (no more "device" symlink in
> class devices). I thought that was a rather convenient way of finding
> which physical device the class device was coupled to.

The plan is to have a single unified tree at /sys/devices, where all
device-directories live below their parents, and /sys/class contains
only symlinks pointing into this single tree, just like /sys/bus.

People want to stack class-devices, but this leads to a /sys/devices
tree and several small trees spread around in /sys/class. These trees
need to be connected by "device"-links and the "class:"-links, which
just doesn't make much sense if you can have one single tree with the
same information.

In the unified tree, the "device"-link will always just point to the
parent device, that's why there is a config option to disable these
links and test current software not to depend on it.

There was a long discussion on lkml about all that, maybe a year ago,
while converting "input".

Thanks,
Kay


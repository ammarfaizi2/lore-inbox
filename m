Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbTEILbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTEILbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:31:37 -0400
Received: from gate.perex.cz ([194.212.165.105]:34053 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262479AbTEILb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:31:29 -0400
Date: Fri, 9 May 2003 13:43:20 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Christoph Hellwig <hch@lst.de>
Cc: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove unused funcion proc_mknod
In-Reply-To: <20030505213004.B24006@lst.de>
Message-ID: <Pine.LNX.4.44.0305091336060.1237-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Christoph Hellwig wrote:

> On Mon, May 05, 2003 at 08:22:48PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > manually.  IOW, removal of proc_mknod() won't solve anything.  The
> > real question is whether we should allow device nodes on procfs.
> > If we should not allow them, ALSA needs API changes.  If we should,
> > it'd be better to have creation of such nodes explicit (and if ALSA
> > keeps doing that, it should switch to calling proc_mknod()).
> 
> We shouldn't.  It's very bad style.  And it seems ALSA also registers a
> chardev and devfs entries for that stuff.
> 
> Jaroslav, can we just drop that junk or is it still used by userland.
> And if yes how long will it take to get an alsa-libs release out to
> not rely on it?

alsa-lib doesn't rely on it at all. The devices in /dev/snd/ might be 
created in these ways:

1) static - using the mknod command
2) using devfs
3) link /dev/snd to /proc/asound/dev

We prefered the third solution because we were changing heavily the device
minor numbers in the past. We can remove the proc dynamic device creating
from our code now. I agree, this code should not be in the kernel tree.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


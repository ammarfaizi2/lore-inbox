Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264304AbUEMQzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbUEMQzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUEMQzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:55:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:60289 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264304AbUEMQzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:55:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16547.43052.87943.11064@xf11.fra.suse.de>
Date: Thu, 13 May 2004 18:54:04 +0200
From: Egbert Eich <eich@pdx.freedesktop.org>
To: dri-devel@lists.sourceforge.net
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: From Eric Anholt:
In-Reply-To: torvalds@osdl.org wrote on Wednesday, 12 May 2004 at 15:32:12 -0700 
References: <200405112211.i4BMBQDZ006167@hera.kernel.org>
	<20040511222245.GA25644@kroah.com>
	<Pine.LNX.4.58.0405120018360.3826@skynet>
	<Pine.LNX.4.58.0405121529540.3636@evo.osdl.org>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > 
 > On Wed, 12 May 2004, Dave Airlie wrote:
 > > 
 > > I just looked at drm.h and nearly all the ioctls use int, this file is
 > > included in user-space applications also at the moment, I'm worried
 > > changing all ints to __u32 will break some of these, anyone on DRI list
 > > care to comment?
 > 
 > Right now, all architectures have "int" being 32-bit, so nothing should 
 > break. Apart from sign issues, of course.
 > 
 > If there are pointers and "long", then those should just not exist. Never
 > expose kernel pointers to user mode (and you really never should pass user
 > pointers back), and "long" should really just be "__u32" instead (since 
 > that is what it is on a 32-bit platform - and if it works there, then it 
 > should work on a 64-bit platform too).
 > 

Unfortunately this is done in some places in DRM. Pointers are used as a 
simple 'handle' to point to areas that are to be mapped by mmap()
from user mode.
I've done some ioctl32() interfaces for DRM for a few drivers (mga, 
radeon, r128) to make 32bit software work on 64bit systems such as AMD64.
In most cases it was easy to work around the longs as they either did
not have to exist at all or could be replaced by something that's
platform independent.
I have plans to submit these ioctl32() interfaces to Mesa when I get
around to do it.
Anyway they are unnecessary kludges which should have been avoided
from the beginning.

Egbert.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbREOT3p>; Tue, 15 May 2001 15:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbREOT3Z>; Tue, 15 May 2001 15:29:25 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46085 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261293AbREOT3Q>; Tue, 15 May 2001 15:29:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Getting FS access events
Date: 15 May 2001 12:28:54 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ds01m$7q9$1@cesium.transmeta.com>
In-Reply-To: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca> <5.1.0.14.2.20010515105633.00a22c10@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <5.1.0.14.2.20010515105633.00a22c10@pop.cus.cam.ac.uk>
By author:    Anton Altaparmakov <aia21@cam.ac.uk>
In newsgroup: linux.dev.kernel
> 
> They shouldn't, but maybe some stupid utility or a typo will do it creating 
> two incoherent copies of the same block on the device. -> Bad Things can 
> happen.
> 
> Can't we simply stop people from doing it by say having mount lock the 
> device from further opens (and vice versa of course, doing a "dd" should 
> result in lock of device preventing a mount during the duration of "dd"). - 
> Wouldn't this be a good thing, guaranteeing that problems cannot happen 
> while not incurring any overhead except on device open/close? Or is this a 
> matter of "give the user enough rope"? - If proper rw locking is 
> implemented it could allow simultaneous -o ro mount with a dd from the 
> device but do exclusive write locking, for example, for maximum flexibility.
> 

This would leave no way (without introducing new interfaces) to write,
for example, the boot block on an ext2 filesystem.  Note that the
bootblock (defined as the first 1024 bytes) is not actually used by
the filesystem, although depending on the block size it may share a
block with the superblock (if blocksize > 1024).

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279556AbRKKTJg>; Sun, 11 Nov 2001 14:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280387AbRKKTJQ>; Sun, 11 Nov 2001 14:09:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:17600 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279741AbRKKTJO>;
	Sun, 11 Nov 2001 14:09:14 -0500
Date: Sun, 11 Nov 2001 14:09:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] long-living cache for block devices
In-Reply-To: <Pine.LNX.4.33.0111111053160.21663-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0111111400180.17411-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Nov 2001, Linus Torvalds wrote:

> If we end up removing the module, we'll call "unregister_blockdev()" or
> whatever, which in turn gets rid of _all_ pages, and that that time we
> will correctly get rid of buffers.
> 
> And before you remove the module I see no advantage to have any guarantees
> of quiescence and removing the buffer heads. I only see extra code that
> doesn't seem to have any real purpose..

As it is, driver has a right to destroy any internal data structures as
soon as the last ->release() is called.  None of them expect requests
coming in after that and frankly, that makes sense.

IOW, if there is any point in _having_ ->release() at all, we'd better
make sure that nothing will bother the driver between the final ->release()
and the next ->open().


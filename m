Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279904AbRKDMF0>; Sun, 4 Nov 2001 07:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279906AbRKDMFQ>; Sun, 4 Nov 2001 07:05:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16065 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S279904AbRKDMFE>;
	Sun, 4 Nov 2001 07:05:04 -0500
Date: Sun, 4 Nov 2001 07:05:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Black <mblack@csihq.com>
cc: Simon Kirby <sim@netnation.com>, linux-kernel@vger.kernel.org
Subject: Re: Something broken in sys_swapon
In-Reply-To: <00a901c16526$48c64300$1a502341@cfl.rr.com>
Message-ID: <Pine.GSO.4.21.0111040702440.20848-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Mike Black wrote:

> I think I see a potential problem (I'm looking at 2.4.10) in fs/namei.c.
> 
> If path_init() returns 0 in __user_walk() then err is not set to anything
> (it defaults to 0)

path_init() returns 0 only if you are in altroot situation (running with
personality that has its own /usr/gnuemul/<...>/) _and_ it had succeeded
doing lookup from the altroot.  Otherwise it returns non-zero and lets
path_walk() do the right thing.


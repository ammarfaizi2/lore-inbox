Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbREWAim>; Tue, 22 May 2001 20:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262928AbREWAic>; Tue, 22 May 2001 20:38:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49084 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262924AbREWAiZ>;
	Tue, 22 May 2001 20:38:25 -0400
Date: Tue, 22 May 2001 20:38:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105230028.CAA79596.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0105222031420.17373-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001 Andries.Brouwer@cwi.nl wrote:

> >> 	dev_t rdev;
> 
> > Reasonable.
> 
> Good. We all agree.
> (But now you see what I meant in comments about mknod.)
> 
> >> 	kdev_t dev;
> 
> > Useless. If you hope that block_device will help to solve rmmod races
> 
> Yes. Why am I mistaken?

Because the problems begin in subsystems. Solving the situation with
block_device_operations is trivial. It's stuff on the character side that
is going to bite you big way. TTY drivers, for example. They are below
the layer where your kdev_t lives.


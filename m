Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269553AbRHCTQX>; Fri, 3 Aug 2001 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269558AbRHCTQN>; Fri, 3 Aug 2001 15:16:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60632 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269553AbRHCTQE>;
	Fri, 3 Aug 2001 15:16:04 -0400
Date: Fri, 3 Aug 2001 15:16:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <20010803203612.I31468@emma1.emma.line.org>
Message-ID: <Pine.GSO.4.21.0108031506180.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Matthias Andree wrote:

> Applications usually protect their playgrounds - separate uid for
> instance. If only the application has access to that area, and itself
> does not trigger races, "at any given moment" is not a restriction.

Bingo. The whole thing relies on second-guessing the application.
BTW, I can think of very legitimate cases when we want to create
a bunch of files, fsync them as we go and then fsync the directory
where they had been created. Application knows what and when should
be synced _and_ it has a way to ask kernel to sync an object.

BTW, symlinks may be a problem - they can't be opened and symlink
creation is asynchronous. And there are applications that _do_
care about them - for all they care, lost symlink is as bad as
the need to scan lost+found


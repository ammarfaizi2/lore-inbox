Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269571AbRHCSx4>; Fri, 3 Aug 2001 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269550AbRHCSxp>; Fri, 3 Aug 2001 14:53:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11193 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269570AbRHCSxe>;
	Fri, 3 Aug 2001 14:53:34 -0400
Date: Fri, 3 Aug 2001 14:53:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <0108032026140F.01827@starship>
Message-ID: <Pine.GSO.4.21.0108031423280.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Daniel Phillips wrote:

> > There is no _locked_ chain.
> 
> Locked as in can't be destroyed (refcount) not i_sem or such, sorry for the
> loose usage.

Sigh... You need i_sem for fsync(). Moreover, there is no warranty that
set of objects you sync has _anything_ to path by the time when you start
syncing the second one. Application has information about the use of
parts of tree it's interested in. Kernel doesn't. Notice that all this
wankage was full of "oh, but MTA doesn't care for symlinks", "oh, but MTA
doesn't deal with parents renamed", ad nausea. You know what it means?
Right, that kernel shouldn't try to second-guess the userland. Application
knows what fs objects it wants synced. Kernel provides a primitive for
syncing an object and leaves the choice of objects to sync to application.

Folks, putting policy into the kernel is Wrong(tm). And that's precisely
what you are advocating here.


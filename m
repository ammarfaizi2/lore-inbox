Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269541AbRHCSIy>; Fri, 3 Aug 2001 14:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbRHCSIj>; Fri, 3 Aug 2001 14:08:39 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22008 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269535AbRHCSIc>;
	Fri, 3 Aug 2001 14:08:32 -0400
Date: Fri, 3 Aug 2001 14:08:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <01080315090600.01827@starship>
Message-ID: <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Daniel Phillips wrote:

> Are you saying that there may not be a ".." some of the time?  Or just 
> that it may spontaneously be relinked?  If it does spontaneously change 
> it doesn't matter, you have still made sure there is access by at least 
> one path.
> 
> The trouble with doing this in userland is, the locked chain of dcache 
> entries isn't there.

There is no _locked_ chain. And if you want to grab the locks on all
ancestors - think again. It means sorting the inodes by address _and_
relocking if any of them had been moved while you were locking the
previous ones. I absolutely refuse to add such crap to the tree and I
seriously suspect that Linus and Alan will do the same.


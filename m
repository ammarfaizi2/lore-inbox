Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSGBWUp>; Tue, 2 Jul 2002 18:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSGBWUp>; Tue, 2 Jul 2002 18:20:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1277 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313070AbSGBWUo>;
	Tue, 2 Jul 2002 18:20:44 -0400
Date: Tue, 2 Jul 2002 18:23:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal 
In-Reply-To: <31775.1025581336@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0207021817500.6472-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jul 2002, Keith Owens wrote:

> Incrementing the use count at registration time is no good, it stops
> the module being unloaded.  Operations are deregistered at rmmod time.
> Setting the use count at registration prevents rmmod from removing the
> module, so you cannot deregister the operations.  Catch 22.

Right.  So you should use try_inc_mod_count() before dereferencing the
registered pointers and treat failure as "not found".
 
> Module unload is not racy on UP without preempt.  It is racy on SMP or
> with preempt.  It used to be safe on SMP because almost everything was
> under the BKL, but that protection no longer exists.

<wry> You forgot "as long as nothing blocks". Which is more than brittle -
code changes routinely violate such warranties. </wry>


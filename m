Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbUELWce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUELWce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUELWce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:32:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:33945 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262109AbUELWcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:32:25 -0400
Date: Wed, 12 May 2004 15:32:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: dri-devel@lists.sourceforge.net
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: From Eric Anholt:
In-Reply-To: <Pine.LNX.4.58.0405120018360.3826@skynet>
Message-ID: <Pine.LNX.4.58.0405121529540.3636@evo.osdl.org>
References: <200405112211.i4BMBQDZ006167@hera.kernel.org> <20040511222245.GA25644@kroah.com>
 <Pine.LNX.4.58.0405120018360.3826@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 May 2004, Dave Airlie wrote:
> 
> I just looked at drm.h and nearly all the ioctls use int, this file is
> included in user-space applications also at the moment, I'm worried
> changing all ints to __u32 will break some of these, anyone on DRI list
> care to comment?

Right now, all architectures have "int" being 32-bit, so nothing should 
break. Apart from sign issues, of course.

If there are pointers and "long", then those should just not exist. Never
expose kernel pointers to user mode (and you really never should pass user
pointers back), and "long" should really just be "__u32" instead (since 
that is what it is on a 32-bit platform - and if it works there, then it 
should work on a 64-bit platform too).

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbSJEBe1>; Fri, 4 Oct 2002 21:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJEBe1>; Fri, 4 Oct 2002 21:34:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23563 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261815AbSJEBeX>; Fri, 4 Oct 2002 21:34:23 -0400
Date: Fri, 4 Oct 2002 18:41:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: viro@math.psu.edu, <linux-kernel@vger.kernel.org>
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <20021004.181311.31550114.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210041839430.13749-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, David S. Miller wrote:
> 
> Another theory is that some device just dislikes being given
> a 0 in one of it's base registers, but somehow ~0 is ok :-)

I think that is the real issue. We're mapping something - probably a host
bridge - at address 0, and then accessing RAM (which is also is mapped at 
PCI address 0) and the host bridge is unhappy.

So excluding the change is probably the right thing to do - it's just 
fundamentally buggy to blindly put a base register at zero.

		Linus


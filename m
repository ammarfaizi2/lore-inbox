Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbSJECCw>; Fri, 4 Oct 2002 22:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSJECCr>; Fri, 4 Oct 2002 22:02:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43747 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261841AbSJECCq>;
	Fri, 4 Oct 2002 22:02:46 -0400
Date: Fri, 04 Oct 2002 19:00:53 -0700 (PDT)
Message-Id: <20021004.190053.69975722.davem@redhat.com>
To: torvalds@transmeta.com
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210041839430.13749-100000@home.transmeta.com>
References: <20021004.181311.31550114.davem@redhat.com>
	<Pine.LNX.4.44.0210041839430.13749-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Fri, 4 Oct 2002 18:41:25 -0700 (PDT)
   
   On Fri, 4 Oct 2002, David S. Miller wrote:
   > Another theory is that some device just dislikes being given
   > a 0 in one of it's base registers, but somehow ~0 is ok :-)
   
   I think that is the real issue. We're mapping something - probably a host
   bridge - at address 0, and then accessing RAM (which is also is mapped at 
   PCI address 0) and the host bridge is unhappy.

We're current blindly putting ~0 in there, how can that be any
better? :-)
   
   So excluding the change is probably the right thing to do - it's just 
   fundamentally buggy to blindly put a base register at zero.
   
And putting ~0 there is ok?

>From what you're saying, that whole routine is fundamentally broken.

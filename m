Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278092AbRJRTZv>; Thu, 18 Oct 2001 15:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278025AbRJRTZl>; Thu, 18 Oct 2001 15:25:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64644 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278092AbRJRTZ1>;
	Thu, 18 Oct 2001 15:25:27 -0400
Date: Thu, 18 Oct 2001 12:25:25 -0700 (PDT)
Message-Id: <20011018.122525.82054118.davem@redhat.com>
To: marcelo@conectiva.com.br
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork() failing
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0110181503220.12276-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0110181503220.12276-100000@freak.distro.conectiva>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Marcelo Tosatti <marcelo@conectiva.com.br>
   Date: Thu, 18 Oct 2001 15:04:15 -0200 (BRST)
   
   As you know, we currently allow 1-order allocations to fail easily. 
   
   However, there is one special case of 1-order allocations which cannot
   fail: fork.
   
   Here is the tested patch against pre4.

There are also some platforms using 1-order allocations
for page tables as well.

But I don't know if I agree with this special casing.
Why not just put something into the GFP flag bits
which distinguishes between high order allocations which
are "critical" and others which are "don't try too hard".

BTW, such a scheme could be useful for page cache pre-fetching.
If you use a high order allocation, it is more likely that all
of the pages in that prefetch will fit into the same kernel TLB
mapping.  We could use a GFP_NONCRITICAL for something like this.

Franks a lot,
David S. Miller
davem@redhat.com

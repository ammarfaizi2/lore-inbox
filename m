Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbTABXMz>; Thu, 2 Jan 2003 18:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267283AbTABXMy>; Thu, 2 Jan 2003 18:12:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63935 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266307AbTABXMx>;
	Thu, 2 Jan 2003 18:12:53 -0500
Date: Thu, 02 Jan 2003 15:13:46 -0800 (PST)
Message-Id: <20030102.151346.113640740.davem@redhat.com>
To: tom@rhadamanthys.org
Cc: linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030102221210.GA7704@window.dhis.org>
References: <20021230012937.GC5156@work.bitmover.com>
	<1041489421.3703.6.camel@rth.ninka.net>
	<20030102221210.GA7704@window.dhis.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Ogrisegg <tom@rhadamanthys.org>
   Date: Thu, 2 Jan 2003 23:12:11 +0100

   > 1) Does not handle writes that straddle multiple VMAs
   
   What exactly do you mean?

If I mmap two areas 1 right after another, then do a write
of comprising of those two areas, your code will only lookup
one of the VMAs.

It's a bug.
   
   > 2) We do not want to encourage people to use this mmap
   >    scheme anyways.  The mmap way consumes precious VM
   >    space, whereas the sendfile scheme does not.
   
   Is that the answer to my "sendfile is now obsolete"?
   
It is a "this patch is unacceptable because" comment.

   Sure we cannot remove sendfile now, as some applications
   depends on it, but that's not what I wanted.
   
That's not what I'm talking about.  I'm saying, making this
mmap thing available makes no sense at all.

   I made this patch, so that _portable_ applications (and sendfile
   is miles away from beeing portable - even if the target has a
   sendfile systemcall, its highly unlikely that it has the same
   semantics as Linux' sendfile) are sped up.
   
This isn't a priority for us.  People who want the best possible
performance can code their apps up to take advantage of sendfile()
on systems that have it.  (and really, show me how many systems
lack a sendfile mechanism these days).

   However, I didn't like the VM waste either, but I believe there
   is no other way.
   
There is a way, convert to sendfile.

   Hehe. In fact that wasn't a really serious claim.

Then don't make such claims.

   > So I think this patch stinks :)
   
   But it worked? If I didn't misunderstood #1 then I don't see a
   problem for integrating it into the current kernel.
   
I think you need to rethink the multiple VMA case in #1, and
also understand why I don't want this facility in the tree
at all anyways.  Apps can convert to sendfile(), and as a result
they'll get improved performance on ALL linux kernels, not just
the ones with your special patch applied.

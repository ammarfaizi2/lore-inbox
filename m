Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbTACAn0>; Thu, 2 Jan 2003 19:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTACAnY>; Thu, 2 Jan 2003 19:43:24 -0500
Received: from stargate-43-81.salzburg-online.at ([213.153.43.81]:43276 "EHLO
	window.dhis.org") by vger.kernel.org with ESMTP id <S267359AbTACAmO>;
	Thu, 2 Jan 2003 19:42:14 -0500
Date: Fri, 3 Jan 2003 01:45:43 +0100
From: Thomas Ogrisegg <tom@rhadamanthys.org>
To: "David S. Miller" <davem@redhat.com>
Cc: tom@rhadamanthys.org, linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20030103004543.GA12399@window.dhis.org>
References: <20021230012937.GC5156@work.bitmover.com> <1041489421.3703.6.camel@rth.ninka.net> <20030102221210.GA7704@window.dhis.org> <20030102.151346.113640740.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102.151346.113640740.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 03:13:46PM -0800, David S. Miller wrote:
>    From: Thomas Ogrisegg <tom@rhadamanthys.org>
>    Date: Thu, 2 Jan 2003 23:12:11 +0100
> 
> It's a bug.

I see. Ok, that can be fixed easily.

>    Sure we cannot remove sendfile now, as some applications
>    depends on it, but that's not what I wanted.
>    
> That's not what I'm talking about.  I'm saying, making this
> mmap thing available makes no sense at all.

No. For portable applications it makes great sense.

>    I made this patch, so that _portable_ applications (and sendfile
>    is miles away from beeing portable - even if the target has a
>    sendfile systemcall, its highly unlikely that it has the same
>    semantics as Linux' sendfile) are sped up.
>    
> This isn't a priority for us.  People who want the best possible
> performance can code their apps up to take advantage of sendfile()
> on systems that have it.

So you want to chain people to your "propritaery solution"?

> (and really, show me how many systems
> lack a sendfile mechanism these days).

What kind of systems are you talking about? Operating systems?
Nearly all.

>    However, I didn't like the VM waste either, but I believe there
>    is no other way.
>    
> There is a way, convert to sendfile.

It might be a bit difficult to convert all applications to
sendfile. Especially those for which you don't have the
source code.

>    But it worked? If I didn't misunderstood #1 then I don't see a
>    problem for integrating it into the current kernel.
>    
> I think you need to rethink the multiple VMA case in #1, and
> also understand why I don't want this facility in the tree
> at all anyways.  Apps can convert to sendfile(), and as a result
> they'll get improved performance on ALL linux kernels, not just
> the ones with your special patch applied.

I don't see your point. Applications which really need the
performance will switch to sendfile anyway because of the
problems with mmap, you mentioned.

My patch is very simple and takes less than 1KB of code but
will speed up many applications and doesn't have a real
drawback (except when sending "normal" data which is larger
than a page - but that shouldn't happen very often).

Yet another advantage of my version is that you can use it
in conjunction with writev.

Unfortunately the linux-sendfile is not as good as the HP-UX
one. Under HP-UX you can define a "struct iovec" header to
be sent before the file is sent.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTJEAJV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 20:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbTJEAJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 20:09:21 -0400
Received: from waste.org ([209.173.204.2]:41911 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262838AbTJEAJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 20:09:20 -0400
Date: Sat, 4 Oct 2003 19:08:57 -0500
From: Matt Mackall <mpm@selenic.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Erlend Aasland <erlend-a@ux.his.no>, Steven French <sfrench@us.ibm.com>,
       James Morris <jmorris@intercode.com.au>,
       Samba Technical Mailing List <samba-technical@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH CIFS] use CryptoAPI MD4/MD5
Message-ID: <20031005000857.GE13573@waste.org>
References: <OF9C1504BB.5FB00D5A-ON87256DB3.0015672E-86256DB3.001798AE@us.ibm.com> <20031002113759.GA19824@badne3.ux.his.no> <Pine.LNX.4.58.0310041058000.5954@twinlark.arctic.org> <20031004182417.GC13573@waste.org> <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0310041127020.5954@twinlark.arctic.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 11:51:57AM -0700, dean gaudet wrote:
> On Sat, 4 Oct 2003, Matt Mackall wrote:
> 
> > On Sat, Oct 04, 2003 at 11:00:01AM -0700, dean gaudet wrote:
> > > what about CryptoAPI is so expensive that you can't use a stack-based
> > > context?
> >
> > The alloc functions hide a bunch of module lookup details and the size
> > of the context structures vary from one alg to the next. They also
> > tend to hide block-sized buffers to deal with fragments. So it's a
> > little ugly but not insurmountable.
> 
> by "block-sized" you mean like 64 bytes for MD5 and SHA1, 16 bytes for
> AES, and so forth?  if so that's no biggie, those are already present
> in most simple library implementations of these algos.  but if "block"
> means 4096 bytes then, aiee.

Cipher-block-sized.
 
> if module lookup is expensive then perhaps a much better api would be one
> which yields a module handle -- and the module handle can be used in a
> much less expensive allocator to create contexts where they're required.
> it seems that the module handle could be a read-only structure and
> therefore shared without locking.

Indeed, I've proposed such an interface. 

> this CIFS patch alone replaces 89 lines with 250 lines of code!

My experience is that aside from the context allocation/locking
issues, the thing is otherwise pretty painless to work with.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

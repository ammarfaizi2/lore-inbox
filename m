Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbTIDShi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTIDSg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:36:56 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:43242
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S265444AbTIDSfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:35:01 -0400
Date: Thu, 4 Sep 2003 18:05:16 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: precise characterization of ext3 atomicity
Message-ID: <20030904160516.GH2359@wind.cocodriloo.com>
References: <3F574A49.7040900@namesys.com> <20030904085537.78c251b3.akpm@osdl.org> <3F576176.3010202@namesys.com> <20030904091256.1dca14a5.akpm@osdl.org> <3F57676E.7010804@namesys.com> <20030904181540.GC13676@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904181540.GC13676@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 11:15:40AM -0700, Mike Fedyk wrote:
> On Thu, Sep 04, 2003 at 08:25:18PM +0400, Hans Reiser wrote:
> > In data=journal and data=ordered modes ext3 also guarantees that the 
> > metadata will be committed atomically with the data they point to.  However 
> > ext3 does not provide user data atomicity guarantees beyond the scope of a 
> > single filesystem disk block (usually 4 kilobytes).  If a single write() 
> > spans two disk blocks it is possible that a crash partway through the write 
> > will result in only one of those blocks appearing in the file after 
> > recovery.
> 
> And how does reiser4 do this without changing the userspace apps?

It won't.


[ snip ] 
> Most files are written with several write() calls, so even if each call is
> atomic, your entire file will not be there.
> 
> Also, ext3 could claim the same atomicity if it only updated meta-data on
> write() call boundaries, instead of block boundaries.

There will be a new API to support userspace-controlled
multifile transactions.

At first stab, multifile transactions will be used internally to
implement extended attributes.

Now, another question is.. will the transaction API support commit() and
rollback()? *grin*

(wonder about coding a simple transactional database with
 shell scripts ;)

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.

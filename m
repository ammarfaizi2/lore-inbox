Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263043AbSJHTBB>; Tue, 8 Oct 2002 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbSJHS75>; Tue, 8 Oct 2002 14:59:57 -0400
Received: from tapu.f00f.org ([66.60.186.129]:15592 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262690AbSJHS7c>;
	Tue, 8 Oct 2002 14:59:32 -0400
Date: Tue, 8 Oct 2002 12:05:13 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021008190513.GA4728@tapu.f00f.org>
References: <1034044736.29463.318.camel@phantasy> <20021008183824.GA4494@tapu.f00f.org> <1034102950.30670.1433.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034102950.30670.1433.camel@phantasy>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Playing the devil's advocate here...  I didn't see this earlier (when
was it discussed, I can't see it looking back either), so sorry if
this sounds circular or I'm going over stuff that has been discussed
before... but...


On Tue, Oct 08, 2002 at 02:49:09PM -0400, Robert Love wrote:

> In other words, this flag pretty much disables the pagecache for
> this mapping, although we happily keep it around for write-behind
> and read-ahead.  But once the data is behind us and safe to kill, we
> do.  It is manual drop-behind.

OK.  What might use this though?  What applications might want to
disable the page-cache but still use write-behind?

> O_DIRECT has a lot of semantics, one of which is to attempt to
> minimize cache effects.

It depends on the OS.  Some OS are broken and treat O_DIRECT as a
hint, Linux and IRIX know it's a *requirement*.

> O_STREAMING would be for your TiVo or network audio streamer.  Any
> file I/O that is inherently sequential and access-once.  No point
> trashing the pagecache with its data - but otherwise the behavior is
> normal.

Actually, this sounds perfect for O_DIRECT.  But I don't know much
about streaming video.

Since you only want the data once, why use the page-cache at all and
needlessly copy?  Certainly, the requirements for O_DIRECT are not
that hard to meet or implement.


Don't get me wrong, I'm not saying this is a bad thing at all.  The
patch is small and elegant so it's hard to object; I'm just trying to
understand where in practice I would use this over O_DIRECT.



  --cw

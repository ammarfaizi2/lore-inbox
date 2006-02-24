Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbWBXWGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbWBXWGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWBXWGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:06:05 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:17832
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932600AbWBXWGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:06:04 -0500
Date: Fri, 24 Feb 2006 16:06:08 -0600
From: Matt Mackall <mpm@selenic.com>
To: John Reiser <jreiser@BitWagon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] inflate pt1: cleanup Huffman table code
Message-ID: <20060224220608.GE13116@waste.org>
References: <6.399206195@selenic.com> <43FF8005.5070700@BitWagon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FF8005.5070700@BitWagon.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 01:52:05PM -0800, John Reiser wrote:
> > Index: 2.6.16-rc4-inflate/lib/inflate.c
> > ===================================================================
> > --- 2.6.16-rc4-inflate.orig/lib/inflate.c	2006-02-22 17:16:07.000000000 -0600
> > +++ 2.6.16-rc4-inflate/lib/inflate.c	2006-02-22 17:16:08.000000000 -0600
> > @@ -117,12 +117,12 @@
> >     an unused code.  If a code with e == 99 is looked up, this implies an
> >     error in the data. */
> >  struct huft {
> > -	u8 e;			/* number of extra bits or operation */
> > -	u8 b;			/* number of bits in this code or subcode */
> >  	union {
> > -		u16 n;		/* literal, length base, or distance base */
> > -		struct huft *t;	/* pointer to next level of table */
> > -	} v;
> > +		u16 val; /* literal, length base, or distance base */
> > +		struct huft *next; /* pointer to next level of table */
> > +	};
> > +	u8 extra; /* number of extra bits or operation */
> > +	u8 bits; /* number of bits in this code or subcode */
> >  };
> 
> How aggressive do you want to be?  About 3.7 years ago in
> http://freshmeat.net/projects/gzip_x86/  I published:
> -----
> typedef unsigned short huft_ndx;  /* index>>1 */
> struct huft {
>   uch e;                /* number of extra bits or operation */
>   uch b;                /* number of bits in this code or subcode */
>   union {
>     ush n;              /* literal, length base, or distance base */
>     huft_ndx t;         /* index>>1 of next level of table */
>   } v;
> };
> -----
> which makes 4==sizeof(struct huft) and enables manipulation by 32-bit
> fetch, exposing 'e' [extra] and 'b' [bits] in x86 byte registers
> for fewer shift-and-mask operations.  The struct huft can be managed
> as a stack of maximum length 1014.

Interesting. The current stuff is mostly obvious cleanups, but I'd
consider something like that after I get the current queue merged.

-- 
Mathematics is the supreme nostalgia of our time.

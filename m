Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbRLNAKy>; Thu, 13 Dec 2001 19:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285274AbRLNAKo>; Thu, 13 Dec 2001 19:10:44 -0500
Received: from ns.suse.de ([213.95.15.193]:29194 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285273AbRLNAKi>;
	Thu, 13 Dec 2001 19:10:38 -0500
Date: Fri, 14 Dec 2001 01:10:34 +0100
From: Andi Kleen <ak@suse.de>
To: adilger@turbolabs.com, linux-kernel@vger.kernel.org
Subject: Re: optimize DNAME_INLINE_LEN
Message-ID: <20011214011034.A7845@wotan.suse.de>
In-Reply-To: <3C192A37.4547D2A7@colorfullife.com> <20011213160706.E940@lynx.no> <20011214002957.A24984@wotan.suse.de> <20011213170350.G940@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213170350.G940@lynx.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 05:03:50PM -0700, Andreas Dilger wrote:
> On Dec 14, 2001  00:29 +0100, Andi Kleen wrote:
> > On Thu, Dec 13, 2001 at 04:07:06PM -0700, Andreas Dilger wrote:
> > > Alternately (also ugly) you could just define struct dentry the as now,
> > > but have a fixed size declaration for d_iname, like:
> > > 
> > > #define DNAME_INLINE_MIN 16
> > > 
> > > 	unsigned char d_iname[DNAME_INLINE_MIN];
> >                    Using [0] here would also work 
> 
> Well, not really.  If we wanted to have a minimum size for the d_iname
> field, then if we declare it as zero and it just squeaks into a chacheline,
> then we may be stuck with 0 bytes of inline names, and _all_ names will
> be kmalloced.

That can be avoided by using a suitable formula for DNAME_INLINE_MIN

> 
> > #define d_... has a similar problem => the potential to break previously
> > compiling source code.
> 
> Again, not really.  The #define d_... scheme would leave all of the fields
> in their original locations, just giving them new names within the named
> struct, and the defines would be the backwards compatible (and probably
> still preferrable) way to access these fields.  I don't _think_ it would
> cause any compiler struct alignment issues to just put the same fields
> in another struct, but I could be wrong.

It won't help if any code is doing

void function()
{ 
	int d_name;
	...
}

Preprocessor doesn't care about scopes so it would turn that into
an syntax error.

Anyways it is moot as Manfred's latest solution looks like the way to go.

-Andi


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTBOTHM>; Sat, 15 Feb 2003 14:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTBOTHM>; Sat, 15 Feb 2003 14:07:12 -0500
Received: from ns.suse.de ([213.95.15.193]:48145 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264903AbTBOTHL> convert rfc822-to-8bit;
	Sat, 15 Feb 2003 14:07:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Date: Sat, 15 Feb 2003 20:17:03 +0100
User-Agent: KMail/1.4.3
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, "Theodore T'so" <tytso@mit.edu>
References: <200302112018.58862.agruen@suse.de> <200302151859.11370.agruen@suse.de> <20030215183959.B22045@infradead.org>
In-Reply-To: <20030215183959.B22045@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302152017.03259.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 February 2003 19:39, Christoph Hellwig wrote:
> On Sat, Feb 15, 2003 at 06:59:11PM +0100, Andreas Gruenbacher wrote:
> > > Please don't do the ugly flags stuff.  We have fsuids and fsgids
> > > for exactly that reason (and because we're still lacking a
> > > credentials cache..).
> >
> > The XATTR_KERNEL_CONTEXT flag cannot be substituted by a uid/gid
> > change; it is unrelated to that; that's the whole point of it. It
> > would be possible to raise some other flag (such as a capability,
> > etc.) instead of passing an explicit flag, but that seems uglier
> > and more problematic/error prone to me.
>
> Then raise CAP_DAC_OVERRIDE.  The right thing would be to pass down a
> struct cred, so we could pass down the magic sys_cred that allows all
> access (look at the XFS ACL code for details on that..), but
> unfortuantately we still don't have proper credentials although there
> were numerous patches around in the last years and we really want it
> for other reasons.

That sounds quite reasonable. I would have to raise CAP_SYS_ADMIN for 
trusted EA's, though. Do you see any potential side effects while a 
pretty powerful capability like CAP_SYS_ADMIN is temporarily raised?

> Magic flags that change the DAC checks work are ugly and will most
> certainly lead to bugs in some implementations sooner or later.

Maybe.


Thanks,
Andreas.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTBOSaI>; Sat, 15 Feb 2003 13:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTBOSaI>; Sat, 15 Feb 2003 13:30:08 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:60426 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264857AbTBOSaH>; Sat, 15 Feb 2003 13:30:07 -0500
Date: Sat, 15 Feb 2003 18:39:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, "Theodore T'so" <tytso@mit.edu>
Subject: Re: [PATCH] Extended attribute fixes, etc.
Message-ID: <20030215183959.B22045@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	Theodore T'so <tytso@mit.edu>
References: <200302112018.58862.agruen@suse.de> <20030215110732.A17564@infradead.org> <200302151859.11370.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302151859.11370.agruen@suse.de>; from agruen@suse.de on Sat, Feb 15, 2003 at 06:59:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 06:59:11PM +0100, Andreas Gruenbacher wrote:
> > Please don't do the ugly flags stuff.  We have fsuids and fsgids for
> > exactly that reason (and because we're still lacking a credentials
> > cache..).
> 
> The XATTR_KERNEL_CONTEXT flag cannot be substituted by a uid/gid change; 
> it is unrelated to that; that's the whole point of it. It would be 
> possible to raise some other flag (such as a capability, etc.) instead 
> of passing an explicit flag, but that seems uglier and more 
> problematic/error prone to me.

Then raise CAP_DAC_OVERRIDE.  The right thing would be to pass down a
struct cred, so we could pass down the magic sys_cred that allows all
access (look at the XFS ACL code for details on that..), but
unfortuantately we still don't have proper credentials although there
were numerous patches around in the last years and we really want it
for other reasons.

Magic flags that change the DAC checks work are ugly and will most
certainly lead to bugs in some implementations sooner or later.


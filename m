Return-Path: <linux-kernel-owner+w=401wt.eu-S1751514AbXAHNIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbXAHNIP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbXAHNIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:08:15 -0500
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:44384 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514AbXAHNIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:08:14 -0500
X-Greylist: delayed 4194 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 08:08:14 EST
Date: Mon, 8 Jan 2007 13:58:17 +0200
From: Sami Farin <safari-xfs@safari.iki.fi>
To: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, David Chinner <dgc@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: BUG: warning at mm/truncate.c:60/cancel_dirty_page()
Message-ID: <20070108115816.GB3803@m.safari.iki.fi>
Mail-Followup-To: xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, David Chinner <dgc@sgi.com>,
	Hugh Dickins <hugh@veritas.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <20070106023907.GA7766@m.safari.iki.fi> <Pine.LNX.4.64.0701062051570.24997@blonde.wat.veritas.com> <20070107222341.GT33919298@melbourne.sgi.com> <20070107144812.96357ff9.akpm@osdl.org> <20070107230436.GU33919298@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107230436.GU33919298@melbourne.sgi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 10:04:36 +1100, David Chinner wrote:
> On Sun, Jan 07, 2007 at 02:48:12PM -0800, Andrew Morton wrote:
> > On Mon, 8 Jan 2007 09:23:41 +1100
> > David Chinner <dgc@sgi.com> wrote:
> > 
> > > How are you supposed to invalidate a range of pages in a mapping for
> > > this case, then? invalidate_mapping_pages() would appear to be the
> > > candidate (the generic code uses this), but it _skips_ pages that
> > > are already mapped.
> > 
> > unmap_mapping_range()?
> 
> /me looks at how it's used in invalidate_inode_pages2_range() and
> decides it's easier not to call this directly.
> 
> > > So, am I correct in assuming we should be calling invalidate_inode_pages2_range()
> > > instead of truncate_inode_pages()?
> > 
> > That would be conventional.
> 
> .... in that case the following patch should fix the warning:

I tried dt+strace+cinfo with this patch applied and got no warnings.
Thanks for quick fix.

-- 
Do what you love because life is too short for anything else.


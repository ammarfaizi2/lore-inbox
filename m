Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUHBExM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUHBExM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 00:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHBExM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 00:53:12 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:33929 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266252AbUHBExI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 00:53:08 -0400
Date: Mon, 2 Aug 2004 15:48:54 +1000
From: Nathan Scott <nathans@sgi.com>
To: Callan Tham <callan.tham@securecirt.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Possible XFS Corruption
Message-ID: <20040802054854.GD21646@frodo>
References: <1091418545.6750.12.camel@taz.lan.securecirt.com> <20040802050232.GB21646@frodo> <1091420414.7363.17.camel@taz.lan.securecirt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091420414.7363.17.camel@taz.lan.securecirt.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 12:20:14PM +0800, Callan Tham wrote:
> On Mon, 2004-08-02 at 13:02, Nathan Scott wrote:
> > > I'm running a Gentoo-patched 2.6.7 kernel, and am experiencing possible
> > > XFS corruption on one of my partitions. I've included a sample of the
> > 
> > Is it reproducible with an unpatched kernel.org kernel?
> > 
> > thanks.
> 
> Hi Nathan,
> 
> Unfortunately, I am unable to test this with a vanilla kernel. However,

Oh?

> looking through the Gentoo patches, they did not touch any of the XFS
> code in a vanilla 2.6.7 kernel.

I would be surprised if they had.  A more likely source of
problems would be changes in the VM subsystem (XFS metadata
buffers are cached in the page cache).

> Is there any other way to diagnose this?

The failure you see is XFS reporting corruption in a directory
btree buffer which didn't have an appropriate magic number at
its start when read in from disk.  There's thousands of potential
reasons why that may have happened;  more often than not these
days its an error thats occured outside of XFS though, and XFS
is passing on the bad news.

If you can find a reproducible test case, you're half way there.
If you can find a reproducible test case on a kernel.org kernel,
you're 95% of the way there, cos then we can more easily help. ;)

cheers.

-- 
Nathan

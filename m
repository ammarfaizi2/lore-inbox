Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVBWXHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVBWXHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBWXFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:05:06 -0500
Received: from waste.org ([216.27.176.166]:41959 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261661AbVBWXDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:03:22 -0500
Date: Wed, 23 Feb 2005 15:03:13 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-ID: <20050223230313.GR3120@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org> <421CFF5E.4030402@mesatop.com> <20050223150333.6ce83aef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223150333.6ce83aef.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 03:03:33PM -0800, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > Andrew Morton wrote:
> > > Steven Cole <elenstev@mesatop.com> wrote:
> > 
> > >> I am having trouble getting recent -mm kernels to boot on my test box.
> > >> For 2.6.11-rc3-mm2 and 2.6.11-rc4-mm1 I get the following:
> > >>
> > >> VFS: Cannot open root device "301" or unknown-block(3,1)
> > >> Please append a correct "root=" boot option
> > >> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,1)
> > >>
> > [snipped]
> > > 
> > > Please set CONFIG_BASE_FULL=y.  Check that this causes CONFIG_BASE_SMALL=0,
> > > then retest.
> > 
> > Yes, that worked.
> 
> hmm, OK.  Matt, we have a block major enumeration problem.  It appears that
> base-small-shrink-chrdevs-hash.patch has the same problem which
> base-small-shrink-major_names-hash.patch had.

Hard to see how that could happen.
 
> >  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be missing.
> > 
> > [root@spc1 steven]# uname -r
> > 2.6.11-rc4-mm1-GX110
> > [root@spc1 steven]# mount -t reiser4 /dev/hdb1 /reiser4_testing
> > mount: special device /dev/hdb1 does not exist
> 
> It would seem that your /dev/hdb1 block-special device node isn't present. 
> Try `mknod /dev/hdb1 3 65'.

He's got devfs. Something change there recently?

-- 
Mathematics is the supreme nostalgia of our time.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262257AbVAUEUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbVAUEUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 23:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVAUEUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 23:20:16 -0500
Received: from mail.suse.de ([195.135.220.2]:46551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262257AbVAUEUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 23:20:11 -0500
Date: Fri, 21 Jan 2005 05:19:59 +0100
From: Andi Kleen <ak@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de, Greg KH <greg@kroah.com>, tiwai@suse.de, mingo@elte.hu,
       rlrevell@joe-job.com, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] compat ioctl security hook fixup
Message-ID: <20050121041959.GA27155@wotan.suse.de>
References: <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050119213818.55b14bb0.akpm@osdl.org> <20050121000935.GA341@mellanox.co.il> <20050120172656.R24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120172656.R24171@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 05:26:56PM -0800, Chris Wright wrote:
> * Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> > Security hook seems to be missing before compat_ioctl in mm2.
> > And, it would be nice to avoid calling it twice on some paths.
> > 
> > Chris Wright's patch addressed this in the most elegant way I think,
> > by adding vfs_ioctl.
> 
> The patch below is against Linus' tree as per Andrew's request.  It will
> conflict with some of the changes in -mm2 (including the some-fixes bit
> from Andi, and LTT).  I also have a patch directly against -mm2 if anyone
> would like to see that instead.

I'm not sure really adding vfs_ioctl is a good idea politically.
I predict we'll see drivers starting to use it, which will cause quite
broken design.

If you add it make at least sure it's not EXPORT_SYMBOL()ed.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753357AbWKFQRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbWKFQRy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbWKFQRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:17:54 -0500
Received: from mail.fieldses.org ([66.93.2.214]:27047 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1753357AbWKFQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:17:53 -0500
Date: Mon, 6 Nov 2006 11:17:47 -0500
To: Daniel J Blueman <daniel.blueman@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, nfsv4@linux-nfs.org,
       Linux Kernel <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: Poor NFSv4 first impressions
Message-ID: <20061106161747.GA12372@fieldses.org>
References: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 12:03:54PM +0000, Daniel J Blueman wrote:
> This has all the symptoms to an open EACCES NFSv4 bug in 2.6.18/19.
> This is fixed in:
> 
> http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.19-rc3-2/linux-2.6.19-rc3-CITI_NFS4_ALL-2.diff
> (see http://www.citi.umich.edu/projects/nfsv4/linux/).
> 
> With this patch, I can run just great with NFSv4 home dir (etc)
> mounts; without, I get the symptom of many 0-byte temporary/lock files
> being created and often the inability to create files (!). Be sure to
> allow callback delegation connections in through your firewall for the
> extra performance ;-) .
> 
> Maybe it's too late for these fixes 2.6.19, but they should certainly
> make 2.6.19.1 IMHO.

Yeah, bad patch management on my part, apologies, I should have pushed
it as soon as I noticed the problem.

Investigating the problem revealed some ugliness (and some races which
will need further work), and I had hoped to have a more complete fix
before now.  Oh well.

Two patches follow; the first does a very simple cleanup, the second
solves the immediate problem in the most straightforward way I can see,
but is a bit of a hack.

--b.

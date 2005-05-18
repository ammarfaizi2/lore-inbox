Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVERUUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVERUUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 16:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVERUUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 16:20:35 -0400
Received: from unthought.net ([212.97.129.88]:4785 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262341AbVERUUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 16:20:16 -0400
Date: Wed, 18 May 2005 22:20:14 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Joshua Baker-LePain <jlb17@duke.edu>
Cc: Chris Wedgwood <cw@f00f.org>, Gregory Brauer <greg@wildbrain.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel OOPS for XFS in xfs_iget_core (using NFS+SMP+MD)
Message-ID: <20050518202014.GZ422@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Joshua Baker-LePain <jlb17@duke.edu>, Chris Wedgwood <cw@f00f.org>,
	Gregory Brauer <greg@wildbrain.com>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <428511F8.6020303@wildbrain.com> <20050514184711.GA27565@taniwha.stupidest.org> <428B7D7F.9000107@wildbrain.com> <20050518175925.GA22738@taniwha.stupidest.org> <20050518195251.GY422@unthought.net> <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505181556410.6834@chaos.egr.duke.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 04:00:08PM -0400, Joshua Baker-LePain wrote:
...
> > 
> > Seriously, any 2.6 earlier than .11 is *unusable* for file serving over
> > NFS (at least with XFS which at the moment is the only FS with
> > journalled quota so at least for me that's the only option).
> 
> Do you have a test case that would show this up?  I've been testing a 
> centos-4 based server with the RH-derived 2.6.9-based kernel tweaked to 
> disable 4K stacks and enable XFS and haven't run into any issues yet.  
> This includes running the parallel IOR benchmark from 10 clients (and 
> getting 200MiB/s throughput on reads).

Server must be SMP

Two clients; on each of them untar/cat/delete kernel trees.

You want a few million files on the FS in order to confuse the server
sufficiently for it to screw up severely.

Make sure you keep lots of things going concurrently on the clients.

And don't run as root - common problems are also that files get wrong
ownership/modes (a file created by one unprivileged user shows up as
belonging to another unprivileged user - files can show up with modes
d---------)

I guess RH could have patched up a 2.6.9 to include whatever fixes (more
than one!) for the issues that were resolved from 2.6.9 to 2.6.11.

-- 

 / jakob


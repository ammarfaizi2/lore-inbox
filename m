Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUIHQRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUIHQRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIHQRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:17:00 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:19949 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S268092AbUIHQQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:16:56 -0400
Date: Wed, 8 Sep 2004 18:16:52 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040908161652.GA4353@ii.uib.no>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
References: <20040908123524.GZ390@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908123524.GZ390@unthought.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 02:35:24PM +0200, Jakob Oestergaard wrote:
> 
> First XFS bug:
> ---------------
> http://oss.sgi.com/bugzilla/show_bug.cgi?id=309

I've shared your frustration this summer:

	http://bugzilla.kernel.org/show_bug.cgi?id=2840
	http://bugzilla.kernel.org/show_bug.cgi?id=2841
	http://bugzilla.kernel.org/show_bug.cgi?id=2929
	http://bugzilla.kernel.org/show_bug.cgi?id=3118


but after 2.6.8.1 and going back to 8K stacks, my fileserver has been
stable.

> XFS causes lowmem oom, triggering the OOM killer. Reported by
> as@cohaesio.com on the 18th of august.

Have you tried if this helps:

	sysctl -w vm.vfs_cache_pressure=10000

Fixed oom-killer problems for me on 2.6.8-rc2. It was very eager to
kill the backup (tivoli storage manager) client.  Haven't needed it so
far on 2.6.8.1. 

> A little info on the hardware:
>  Big server             Small server
> ---------------------- -----------------------
> Intel Xeon              Dual Athlon MP
> 7 external SCSI disks   4 internal IDE disks
> IBM hardware RAID       Software RAID-1 + LVM
> 600+ GB XFS             ~150 GB XFS
> 17+ M files             ~1 M files


Dual pentium-III (IBM x330)
2 TB Infortren Eonstore, fibre channel
500 GB in use
~5 M files


Also have another dual Xeon (Dell PowerEdge 2650) with ~1 TB on XFS,
but that's running 2.4.20-30.8.XFS1.3.1smp, and has never had any
problems. 

> 
> Does anyone actually use XFS for serious file-serving?  

Yes,

> 
> If XFS is a no-go because of lack of support, is there any realistic
> alternatives under Linux (taking our need for quota into account) ?
> 
> And finally, if Linux is simply a no-go for high performance file
> serving, what other suggestions might people have?  NetApp?

My impression so far has been more that the 2.6-series might not yet
have been stable enough. Have had to be chasing the leading/bleeding
edge to get away from the known problems.  Was looking forward to a
real "maintainer" taking over this series, but that doesn't seem to be
happening.. 


  -jf

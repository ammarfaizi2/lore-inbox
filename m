Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWFAWEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWFAWEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 18:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWFAWEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 18:04:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34973 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750746AbWFAWEg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 18:04:36 -0400
Date: Fri, 2 Jun 2006 08:04:07 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Janos Haar <djani22@netcenter.hu>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen 64bit linux)
Message-ID: <20060602080406.C530100@wobbly.melbourne.sgi.com>
References: <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs> <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu> <1149038431.21827.20.camel@localhost.localdomain> <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs> <Pine.LNX.4.61.0605312353530.30170@yvahk01.tjqt.qr> <00d901c6854d$1fc49230$1800a8c0@dcccs> <Pine.LNX.4.61.0606011143410.3533@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0606011143410.3533@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Thu, Jun 01, 2006 at 11:44:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 11:44:46AM +0200, Jan Engelhardt wrote:
> >> Reinit:
> >>
> >> quotaoff /mntpt
> >> umount /mntpt
> >> mount /mntpt
> >
> >Thanks! :-)
> >
> Too bad XFS does not reinit quota on these commands:
> 
> qutoaoff /mp
> quotaon /mp

Hmm, remount would be saner if we wanted to take that approach...

> Yes, it would lock the filesystem for a moment, but that's better than 
> trying to unmount it under someone having inodes open!

But its not just a moment, a quotacheck needs to scan every inode
in the filesystem (on disk) to correctly account for all space/inode
usage.  Its not something to be encouraging people to do frequently,
and it would also be very difficult to correctly implement (while the
filesystem is actively being modified I mean).

cheers.

-- 
Nathan

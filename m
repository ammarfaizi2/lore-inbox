Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSDDWzF>; Thu, 4 Apr 2002 17:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311866AbSDDWy4>; Thu, 4 Apr 2002 17:54:56 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26359
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311839AbSDDWyl>; Thu, 4 Apr 2002 17:54:41 -0500
Date: Thu, 4 Apr 2002 14:56:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid5 resync slow with one linear array
Message-ID: <20020404225643.GG961@matchmail.com>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020402022822.GA961@matchmail.com> <15531.53380.136055.226784@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 02:03:16PM +1000, Neil Brown wrote:
> On Monday April 1, mfedyk@matchmail.com wrote:
> > Hi,
> > 
> > I just setup a 4 (5 really) drive raid5 array.
> > 
> > It is syncing up right now and nothing else is running on the system.
> > 
> > I have three 18GB SCA scsi drives and 2x9GB linear array in a four "drive"
> > raid5 array.
> > 
> > Unfortunately, it is syncing up quite slowly.  Only about 2MB/sec on a
> > 40MB/sec array.  The system is idle.
> > 
> > 2.4.19-pre4-ac3
> > 
> > Is there something about this config that says "Don't do that!"?  I've
> > heard about RAID10, but not Linear+RAID5...
> 
> echo 10000  > /proc/sys/dev/raid/speed_limit_min
> 
> md tries to monitor the activity on the component devices and limits
> rebuild activity when there appears to be other activity.
> It measures "other activity" as "blocks added to kstat.dk_drive_?blk",
> minus "block due to resync activity".
> 
> When a component device is an md array, nothing gets recorded
> in kstat, but lots is recorded as resync activity, so this "other 
> activity" appears as a negative number which, due to storage in an
> unsigned long, appears rather large.
> 
> NeilBrown

Yeah, thought it was something like that.  Thanks for the explanation.  I
didn't see your message until I sent the other one.

Mike

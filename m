Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSDDEBD>; Wed, 3 Apr 2002 23:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDDEAx>; Wed, 3 Apr 2002 23:00:53 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:65432 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S292289AbSDDEAl>; Wed, 3 Apr 2002 23:00:41 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Thu, 4 Apr 2002 14:03:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15531.53380.136055.226784@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid5 resync slow with one linear array
In-Reply-To: message from Mike Fedyk on Monday April 1
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 1, mfedyk@matchmail.com wrote:
> Hi,
> 
> I just setup a 4 (5 really) drive raid5 array.
> 
> It is syncing up right now and nothing else is running on the system.
> 
> I have three 18GB SCA scsi drives and 2x9GB linear array in a four "drive"
> raid5 array.
> 
> Unfortunately, it is syncing up quite slowly.  Only about 2MB/sec on a
> 40MB/sec array.  The system is idle.
> 
> 2.4.19-pre4-ac3
> 
> Is there something about this config that says "Don't do that!"?  I've
> heard about RAID10, but not Linear+RAID5...

echo 10000  > /proc/sys/dev/raid/speed_limit_min

md tries to monitor the activity on the component devices and limits
rebuild activity when there appears to be other activity.
It measures "other activity" as "blocks added to kstat.dk_drive_?blk",
minus "block due to resync activity".

When a component device is an md array, nothing gets recorded
in kstat, but lots is recorded as resync activity, so this "other 
activity" appears as a negative number which, due to storage in an
unsigned long, appears rather large.

NeilBrown

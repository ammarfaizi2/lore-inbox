Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266984AbSKUT1d>; Thu, 21 Nov 2002 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbSKUT11>; Thu, 21 Nov 2002 14:27:27 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:58278 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S266980AbSKUT1X>; Thu, 21 Nov 2002 14:27:23 -0500
Date: Thu, 21 Nov 2002 11:34:24 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021121193424.GB770@nic1-pc.us.oracle.com>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com> <15836.7011.785444.979392@notabene.cse.unsw.edu.au> <20021121014625.GA14063@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121014625.GA14063@redhat.com>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 08:46:25PM -0500, Doug Ledford wrote:
> I haven't yet played with the new dm code, but if it's like I expect it to 
> be, then I predict that in a few years, or maybe much less, md and dm will 
> be two parts of the same whole.  The purpose of md is to map from a single 

	Most LVMs support mirroring as an essential function.  They
don't usually support RAID5, leaving that to hardware.
	I certainly don't want to have to deal with two disparate
systems to get my code up and running.  I don't want to be limited in my
mirroring options at the block device level.
	DM supports mirroring.  It's a simple 1:2 map.  Imagine this LVM
volume layout, where volume 1 is data and mirrored, and volume 2 is some
scratch space crossing both disks.

	[Disk 1]	[Disk 2]
	  [volume 1]	  [volume 1 copy]
          [       volume 2              ]
	
	If DM handles the mirroring, this works great.  Disk 1 and disk
2 are handled either as the whole disk (sd[ab]) or one big partition on
each disk (sd[ab]1), with DM handling the sizing and layout, even
dynamically.
	If MD is handling this, then the disks have to be partitioned.
sd[ab]1 contain the portions of md0, and sd[ab]2 are managed by DM.  I
can't resize the partitions on the fly, I can't break the mirror to add
space to volume 2 quickly, etc.

Joel

-- 

"There are only two ways to live your life. One is as though nothing
 is a miracle. The other is as though everything is a miracle."
        - Albert Einstein

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

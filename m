Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbSKMCxh>; Tue, 12 Nov 2002 21:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267108AbSKMCxh>; Tue, 12 Nov 2002 21:53:37 -0500
Received: from [203.117.131.12] ([203.117.131.12]:29890 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S267107AbSKMCxg>; Tue, 12 Nov 2002 21:53:36 -0500
Message-ID: <3DD1C046.3010603@metaparadigm.com>
Date: Wed, 13 Nov 2002 11:00:22 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Steven Dake <sdake@mvista.com>
Cc: Brian Jackson <brian-kernel-list@mdrx.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
References: <20021113002529.7413.qmail@escalade.vistahp.com> <3DD1A899.8080800@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/02 09:19, Steven Dake wrote:
> Brian,
> 
> The RAID driver does indeed work with shared storage, if you don't have 
> RAID autostart set as the partition type.  If you do, each host will try 
> to rebuild the RAID array resulting in really bad magic.
> 
> I posted patches to solve this problem long ago to this list and 
> linux-raid, but Neil Brown (md maintainer) rejected them saying that 
> access to a raid volume should be controlled by user space, not by the 
> kernel.  Everyone is entitled to their opinions I guess. :)
> 
> The patch worked by locking RAID volumes to either a FibreChannel host 
> WWN (qlogic only) or scsi host id.  This ensured that if a raid volume 
> was started, it could ONLY be started on the host that created it.  This 
> worked for the autostart path as well as the start path via IOCTL.
> 
> I also modified mdadm to handle takeover for failed nodes to takeover 
> RAID arrays.
> 
> I'm extending this type of support into LVM volume groups as we speak. 
> If you would like to see the patch when I'm done mail me and I'll send 
> it out.  This only applies to 2.4.19.

I'm interested in finding what magic is required to get a stable
setup with qlogic drivers and LVM. I have tested many kernel combinations,
vendor kernels, stock, -aa and variety of different qlogic drivers
inclusing the one with the alleged stack hog fixes and they all ooops
when using LVM (can take up to 10 days of production load). Removing
LVM 45 days ago and now I have 45 days uptime on these boxes.

I'm currently building a test setup to try and excercise this problem
as all my other boxes with qlogic cards are production and can't be
played with. I really miss having volume management and a SAN setup
is really where you need it the most.

~mc


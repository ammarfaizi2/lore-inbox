Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbUJ1PWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbUJ1PWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUJ1PNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:13:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23684 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261701AbUJ1PIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:08:00 -0400
Date: Thu, 28 Oct 2004 15:56:04 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Andrew Morton <akpm@osdl.org>, Mathieu Segaud <matt@minas-morgul.org>,
       axboe@suse.de, jfannin1@columbus.rr.com, agk@redhat.com,
       christophe@saout.de, Linux Kernel <linux-kernel@vger.kernel.org>,
       bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
Message-ID: <20041028145604.GA20448@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>,
	Andrew Morton <akpm@osdl.org>,
	Mathieu Segaud <matt@minas-morgul.org>, axboe@suse.de,
	jfannin1@columbus.rr.com, christophe@saout.de,
	Linux Kernel <linux-kernel@vger.kernel.org>, bzolnier@gmail.com
References: <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de> <877jpcgolt.fsf@barad-dur.crans.org> <20041027132422.760d5f5e.akpm@osdl.org> <Pine.LNX.4.61.0410281245240.31882@silk.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410281245240.31882@silk.corp.fedex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 12:52:20PM +0800, Jeff Chua wrote:
> I'm using 2.6.10-rc1 and got the following error ...
> # lvcreate -L 100M -n lv01 vg01
>   device-mapper ioctl cmd 0 failed: Inappropriate ioctl for device
>   striped: Required device-mapper target(s) not detected in your kernel
>   lvcreate: Create a logical volume
 
But that's *not* the dio problem we're discussing in this thread.
It's saying userspace communication with device-mapper isn't working,
most likely because there's something wrong with the way your
system creates /dev/mapper/control when booting or the ioctl 
compatibility code (what architecture?).

Alasdair
-- 
agk@redhat.com

Subject: Re: 2.6.9-mm1: LVM stopped working
Reply-To:
In-Reply-To: <20041026140925.GO16193@agk.surrey.redhat.com>
                                                                                                                                                         
On Tue, Oct 26, 2004 at 03:09:25PM +0100, Alasdair G Kergon wrote:
> On Tue, Oct 26, 2004 at 09:55:38PM +0800, Jeff Chua wrote:
> > It doesn't work on 2.6.10-rc1 either. Works fine on 2.6.9 and 2.4.8-rc1.
> >   device-mapper ioctl cmd 0 failed: Inappropriate ioctl for device
>
> Do you get any corresponding kernel messages?
> Check /dev/mapper/control corresponds to  /proc/devices & /proc/misc.
> (See device-mapper scripts/devmap_mknod.sh)
> Use 'dmsetup version' and 'dmsetup targets' to test.
>
> Alasdair
> --
> agk@redhat.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285045AbRLFIb4>; Thu, 6 Dec 2001 03:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLFIbq>; Thu, 6 Dec 2001 03:31:46 -0500
Received: from [203.161.228.202] ([203.161.228.202]:52749 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S285045AbRLFIbn>; Thu, 6 Dec 2001 03:31:43 -0500
Date: Thu, 6 Dec 2001 16:30:56 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: ext3-users@redhat.com
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        anton@samba.org, axboe@suse.de
Subject: 2.4.17-pre2+ext3-0.9.16+anton's cache aligned smp
Message-ID: <20011206163056.A15550@outblaze.com>
In-Reply-To: <3C0B12C5.F8F05016@zip.com.au> <1007595740.818.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1007595740.818.2.camel@phantasy>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.17-pre2 + ext3-0.9.16 + Anton Blanchards
cacheline_aligned_smp patch available at

http://samba.org/~anton/linux/cacheline_aligned/

Running this on a dual Xeon 500/2GB ram attached to a 3ware 6200 with
2x20 IDE disks. RH 7.2 [pain to install on a 440GX+3ware]. Make sure to
look at this bugzilla entry

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=54741

BTW, make install is borked on RH 7.2 (if you use grub) unless you
comment out the lilo in /sbin/installkernel

Workload was two client machines each with 50 mysql clients making mysql
queries to this machine which the local database jock had written, mix
of inserts,selects,update etc

mysqladmin status on the server showed around 2100 queries/sec. 
Seemed very responsive. I'll be adding some more client machines and
reducing server memory and testing further

With Anton's patch, the number of ctx-swtch/sec drops by around 3000
from avg of 9000 (for 17-pre2+ext3) to avg of 6000 (with anton) as seen
by vmstat 1

Load avg is around 4-5 for this compared to 10-12 for 2.4.7-10smp as
installed by RH

I'm also trying to see if I can get test with Jen Axboe's blk-highmem
patch, It applies cleanly to 2.4.17-pre2+ext3-0.9.16 but I can't seem to
get CONFIG_HIGHIO configured via make {old,menu}config. Any gurus want
to take a look. I'd really like to reduce usage of bounce buffers.

Also, on #kernelnewbies, Andre Hedrick claims blk-highmem eats your
data. That didn't occur last time I tested it. I thought it was rock
solid and ready for inclusion. Anybody confirm/deny ?

> On Mon, 2001-12-03 at 00:51, Andrew Morton wrote:
> > An ext3 update which also applies to linux-2.4.16 is available at
> > 
> > 	http://www.zip.com.au/~akpm/linux/ext3/
> > 
> > Quite a lot of miscellany here.  It would be appreciated if interested
> > parties could please test it in preparation for sending upstream.  Thanks.
> 
> Running 2.4.17-pre4 + preempt-kernel + ext3-0.9.16.
> 
> System survived a preliminary stress test, involving I/O and VM
> pressure, with no problems.  Seems solid here.
> 
> Also, subjectively the combination of 2.4.17-pre2+ and this ext3 patch
> yields better performance under load.  Can't comment which provide the
> benefit without testing, but hey, it's the user experience that counts.
> 
> 	Robert Love

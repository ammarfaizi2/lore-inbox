Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289175AbSAVRqT>; Tue, 22 Jan 2002 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSAVRqI>; Tue, 22 Jan 2002 12:46:08 -0500
Received: from unthought.net ([212.97.129.24]:16842 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S289175AbSAVRqB>;
	Tue, 22 Jan 2002 12:46:01 -0500
Date: Tue, 22 Jan 2002 18:46:00 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Alok K. Dhir" <alok@dhir.net>, linux-kernel@vger.kernel.org
Subject: Re: Autostart RAID 1+0 (root)
Message-ID: <20020122184600.C11697@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Bill Davidsen <davidsen@tmr.com>, "Alok K. Dhir" <alok@dhir.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <001201c1a03e$e654acd0$9865fea9@pcsn630778> <Pine.LNX.3.96.1020122120342.27404A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1020122120342.27404A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Tue, Jan 22, 2002 at 12:15:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 12:15:28PM -0500, Bill Davidsen wrote:
> On Fri, 18 Jan 2002, Alok K. Dhir wrote:
> 
> > I want to test using a software RAID 1+0 partition as root: md0 and md1
> > set up as mirrors between two disks each, and md2 set up as a stripe
> > between md0 and md1.  However, the RedHat 7.2 installer doesn't allow
> > creating nested RAID partitions.
> 
> Here's my understanding. If you are using hardware RAID you can do
> anything your controller supports, and it looks like a single drive to the
> CPU. But if you are looking for reliable boot, you need to use /boot as a
> RAID-1 partition on the first two drives, and make that partition the
> active partition (that may not be needed with your BIOS).

I think he is referring to software RAID. And yes, it is indeed a problem
that the RedHat installer cannot create nested RAIDs (at least, I too was
unable to do that, so either it's impossible, or I'm equally blind).

> This is because if the first disk fails totally, the 2nd will be used to
> boot. You also should use an initrd image to be sure all you need to get
> up is on that small mirrored partition. After that your other partitions
> can be whatever pleases you.

Also, GRUB/LILO only support booting from RAID-1 (or no RAID).

...
> > 
> > Does the kernel support autostarting nested RAID partitions?
> > 

Yes it does.  If you have persistent superblocks on all arrays, they
*should* autostart.

If you boot from the 4G disk, does the array start properly ?  Does
it start properly even if you remove your /etc/raidtab ?

Please check that you have the correct RAID levels either compiled
into your kernel, or on an initrd.

> > Is doing software 1+0 a bad idea anyway due to performance issues?
> 
> It should outperform most other RAID configs under heavy load, but in most
> cases RAID-5 is fine for system which don't need the absolute highest
> performance. Note that the extra writes are queued and there are no extra
> reads unless it is in recovery mode. RAID-1 can be faster, because there
> are two copies of the data, if one drive is busy the other can be used. I
> haven't checked to see that software RAID does that correctly and gets the
> benefit.

A performance improvement went into 2.4 at some stage - all newer 2.4 kernels
will schedule reads to the mirror which has it's head nearest to where the
read should occur.  This works very well in my experience.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

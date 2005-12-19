Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVLSBR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVLSBR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVLSBR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:17:59 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:44814 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1030209AbVLSBR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:17:59 -0500
Date: Mon, 19 Dec 2005 12:18:00 +1100
From: CaT <cat@zip.com.au>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: anticipatory scheduler and raid rebuild
Message-ID: <20051219011800.GI4212@zip.com.au>
References: <20051213052329.GM4212@zip.com.au> <17317.62101.886020.592277@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17317.62101.886020.592277@cse.unsw.edu.au>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 10:36:53AM +1100, Neil Brown wrote:
> > mdadm --manage -a /dev/md6 /dev/sdb8
> > 
> > And then the server slowed to a crawl. Well not even that. It slowed to
> > the point of freezing and occasionally stuttering with activity other
> > then the rebuild. I got a similar reaction when it was rebuilding
> > it.
> 
> I've heard reports of this sort of thing before I think, but I'm
> wondering why I never experience it.
> What sort of drives do you have? What controller?

2 x WD 10k RPM 74GB in this case. The other experience was on 36GB versions.
Controller is:

0000:00:1f.2 RAID bus controller: Intel Corp. 6300ESB SATA RAID
Controller (rev 02)

RAID is turned off so it's acting as a straight SATA controller.

The server itself is an IBM x306 xServe.

> What filesystem are you running over the raid1?

ext3.

> > So, does my hardware suck and AS is pushing it beyond its limits or is
> > AS unsuitable for the task I am putting it through or is AS buggy and
> > all should be well with it?
> 
> I suspect it is an odd interaction between md/raid1/rebuild and AS.
> AS tries to guess how a process is behaving and the raid1/rebuild
> process probably is confusing it.  But it is hard to say how until I
> can reproduce it.

Well so far I've had a 100% reproduction rate. (joy? :)

I'm also experiencing something similar on another box. This time the
kernel is 2.6.8.1 (mandrake kernel build) but the hardware (apart from
hds) is thesame. The HDs are 2 sata drives (an 80gb Maxtor and a 160gb
Seagate) and a USB drive (200GB Seagate). The 80gb Maxtor is very busy
but the box is coasting along. When I do an rsync from the USB drive to
the 160GB Seagate all hell breaks loose. After a few seconds (maybe
15-30) load starts hitting 100 and the whole system begins to stutter.
Mail delivery on the 80GB almost stops and the queue shoots up. It takes
a long time for the system to recover. Even after I ^Z the rsync the
load reminds absurdly high and the queue continues to build. Slowly
though things calm down and maybe half an hour later things are back to
'normal'. AS is in use.

I'm going to see if the same thing happens rsyncing from the 80GB Maxtor to
the 160GB seagate. I'll also probably upgrade the kernel (it IS rather
old and I have a downtime schedueled soon so I should be able to do
this) to a recent 2.6.14. I figured I'd throw this into the mix as the
symptoms appear similar (although that could be coincidance).

Oh, and rsyncing from the 80GB maxtor to the USB drive didn't seem to
hurt things anywhere near as much. I was able to rsync the entire 80GB
drive with the rsync being 2 mins on followed by 2 mins off (ie I let it
copy for 2 mins, driving the load and queue up and then letting it rest
for 2 mins of normal load let it recover fully most of the time), That was
with an older mandrake build of 2.6.8.1 though.

If you need anything from me to help with this ask and I'll see what I
can do.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby

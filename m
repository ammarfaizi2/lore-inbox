Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285552AbRLSWQA>; Wed, 19 Dec 2001 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285540AbRLSWPu>; Wed, 19 Dec 2001 17:15:50 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:2131 "EHLO
	tsmtp9.mail.isp") by vger.kernel.org with ESMTP id <S285534AbRLSWPi>;
	Wed, 19 Dec 2001 17:15:38 -0500
Date: Wed, 19 Dec 2001 23:17:44 +0100
From: Diego Calleja <grundig@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Edward Muller <emuller@learningpatterns.com>
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011219231744.A378@diego>
In-Reply-To: <20011217002350.D418@diego> <20011217024529.E418@diego> <1008780992.8835.2.camel@akira.learningpatterns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1008780992.8835.2.camel@akira.learningpatterns.com>; from emuller@learningpatterns.com on Wed, Dec 19, 2001 at 17:56:31 +0100
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001 17:56:31 Edward Muller wrote:
> On Sun, 2001-12-16 at 20:45, Diego Calleja wrote:
> [snip]
> 
> > As you said, i've tested the drive:
> > 
> > root@diego:~# badblocks -n -vv /dev/hdc5
> > attempt to access beyond end of device
> > 16:05: rw=0, want=9671068, limit=9671067
> > 967106456/  9671067
> > attempt to access beyond end of device
> > 16:05: rw=0, want=9671068, limit=9671067
> > 9671065
> > attempt to access beyond end of device
> > 16:05: rw=0, want=9671068, limit=9671067
> > 9671066
> > done
> > Pass completed, 3 bad blocks found.
> [snip]
> 
> From an earlier email...
> Well, I've run badblocks in 2.4.16
> results:
> 
> 
> root@diego:~# badblocks -n -vv /dev/hdc5
> Initializing random test data
> Checking for bad blocks in non-destructive read-write mode
> From block 0 to 9671067
> Checking for bad blocks (non-destructive read-write test): done
> Pass completed, 0 bad blocks found.
> root@diego:~#
> 
> 
> So under 2.4.17-rc1 Diego gets the '...access beyond end of device' and
> with 2.4.16 he doesn't.
I've made a partition, about 1500 MB.
-Boot 2.4.16-->fdisk-->reboot-->boot 2.4.16-->mkreiserfs-->badblocks -n -vv
(no "..accesbeyond of device)-->reboot-->boot 2.4.17-rc1-->badblocks -n
-vv--> no "..access beyond of device"

> 
> For some reason the badblocks program under 2.4.16 ends at block
> 9671067, while the 2.4.17-rc1 test tries to go beyond that for some
> reason.
> 
> Diego, what happens when you run the fsk/try to access /etc/mtab (and
> the like) under 2.4.16?
ls /etc/mtab && reiserfsck --> same results, in 2.4.16 and in 2.4.17-rc1
--my reiserfs partition is now corrupted, there's no difference between
using 2.4.16 or 2.4.17-rc1--

Now I'll compile 2.4.17-rc2 and I'll run reiserfsck --rebuild-tree. I think
this will sove the problem. But nobody knows know why it happened. I'll
try to test if I can reproduce the bug, but I don't think I can.


Diego Calleja

> 
> 
> -- 
> -------------------------------
> Edward Muller
> Director of IS
> 
> 973-715-0230 (cell)
> 212-487-9064 x115 (NYC)
> 
> http://www.learningpatterns.com
> -------------------------------
> 
> 



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262830AbSJLGtw>; Sat, 12 Oct 2002 02:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262831AbSJLGtw>; Sat, 12 Oct 2002 02:49:52 -0400
Received: from fastmail.fm ([209.61.183.86]:22463 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S262830AbSJLGtu>;
	Sat, 12 Oct 2002 02:49:50 -0400
X-Mail-from: robm@fastmail.fm
X-Spam-score: -0.1
X-Epoch: 1034405738
X-Sasl-enc: QyKsU21bMQmO698f9VYkAA
Message-ID: <101101c271bc$2eebf080$1900a8c0@lifebook>
From: "Rob Mueller" <robm@fastmail.fm>
To: <linux-kernel@vger.kernel.org>
Cc: "Joseph D. Wagner" <wagnerjd@prodigy.net>,
       "Jeremy Howard" <jhoward@fastmail.fm>
References: <001401c2719b$9d45c4a0$53241c43@joe>
Subject: Re: Strange load spikes on 2.4.19 kernel
Date: Sat, 12 Oct 2002 16:54:14 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1) If you don't need to know when a file was last accessed, mount the
> ext3 file system with the -noatime option.  This disables updating of
> the "Last Accessed On:" property, which should significantly increase
> throughput.

Yes, already did that. Should have noted our fstab entry:

/dev/sda2  /   ext3    defaults,noatime 1 1

> /sbin/elvtune -r 16384 -w 8192 /dev/mount-point
> where mount-point is the partition (e.g. /dev/hda5)

Thanks, we'll give this a try. Didn't know about this one before.

> 3) If the above don't work, double the journal size.

As you noted, we seem to be doing more reads than writes, so I'd be suprised
if 192M wasn't enough...

> P.S.  You'd probably get more help from the ext3 mailing list.

I wasn't too sure that it was an I/O problem, which is why I posted here. As
the vmstat output showed, there didn't seem to be any sudden excessive I/O
occuring, but the load would jump enormously.

Maybe we should definitely try some different journaling modes, or disabling
journalling all together, to test if that is the actual culprit...

Rob

PS. I forgot to include the uptime dump in my last post. I just wanted to
show how spikey it was. Basically there's a long falling off decay, and then
a sudden spike again... which decays off... and then spikes again...
basically repeat what you see below over and over and over in 5-10 minute
intervals...

  1:29am  up 23:50,  3 users,  load average: 0.35, 2.49, 2.73
  1:29am  up 23:51,  2 users,  load average: 0.45, 2.44, 2.71
  1:29am  up 23:51,  2 users,  load average: 0.70, 2.42, 2.71
  1:29am  up 23:51,  2 users,  load average: 0.59, 2.34, 2.68
  1:29am  up 23:51,  2 users,  load average: 0.58, 2.28, 2.65
  1:29am  up 23:51,  2 users,  load average: 0.49, 2.21, 2.62
  1:30am  up 23:51,  2 users,  load average: 0.49, 2.15, 2.60
  1:30am  up 23:52,  2 users,  load average: 21.39, 6.43, 3.98
  1:30am  up 23:52,  2 users,  load average: 18.10, 6.22, 3.94
  1:30am  up 23:52,  2 users,  load average: 15.32, 6.01, 3.89
  1:30am  up 23:52,  2 users,  load average: 13.04, 5.83, 3.86
  1:30am  up 23:52,  2 users,  load average: 11.03, 5.64, 3.81
  1:31am  up 23:52,  2 users,  load average: 9.41, 5.47, 3.78
  1:31am  up 23:53,  2 users,  load average: 7.96, 5.29, 3.74
  1:31am  up 23:53,  2 users,  load average: 6.81, 5.13, 3.70
  1:31am  up 23:53,  2 users,  load average: 5.76, 4.96, 3.66
  1:31am  up 23:53,  2 users,  load average: 4.88, 4.80, 3.62
  1:31am  up 23:53,  2 users,  load average: 4.13, 4.64, 3.58
  1:32am  up 23:53,  2 users,  load average: 3.49, 4.48, 3.54
  1:32am  up 23:54,  2 users,  load average: 2.95, 4.34, 3.51
  1:32am  up 23:54,  2 users,  load average: 2.50, 4.19, 3.47
  1:32am  up 23:54,  2 users,  load average: 2.12, 4.05, 3.43
  1:32am  up 23:54,  2 users,  load average: 1.79, 3.92, 3.39
  1:32am  up 23:54,  2 users,  load average: 1.51, 3.79, 3.36
  1:33am  up 23:54,  2 users,  load average: 1.43, 3.70, 3.33
  1:33am  up 23:55,  2 users,  load average: 1.21, 3.58, 3.30
  1:33am  up 23:55,  2 users,  load average: 1.03, 3.46, 3.26
  1:33am  up 23:55,  2 users,  load average: 1.03, 3.38, 3.23
  1:33am  up 23:55,  2 users,  load average: 0.87, 3.27, 3.20
  1:33am  up 23:55,  2 users,  load average: 0.82, 3.17, 3.17


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287255AbSALSVM>; Sat, 12 Jan 2002 13:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287274AbSALSU5>; Sat, 12 Jan 2002 13:20:57 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:8701 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S287255AbSALSTr>; Sat, 12 Jan 2002 13:19:47 -0500
Message-ID: <00fd01c19b95$b3ec3a40$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <009e01c19b7c$463457d0$02c8a8c0@kroptech.com> <20020112173018.Q1482@inspiron.school.suse.de>
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac
Date: Sat, 12 Jan 2002 13:19:41 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Jan 2002 18:19:41.0384 (UTC) FILETIME=[B3E7F480:01C19B95]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Andrea Arcangeli" <andrea@suse.de>
To: "Adam Kropelin" <akropel1@rochester.rr.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Saturday, January 12, 2002 11:30 AM
Subject: Re: Writeout in recent kernels/VMs poor compared to last -ac


> On Sat, Jan 12, 2002 at 10:17:39AM -0500, Adam Kropelin wrote:
> > I recently began regularly transferring large (600 MB+) files to my
> > Linux-based fileserver and have noticed what I would characterize as poor
> > writeout behavior under this load. I've done a bit of comparison testing
> > which may help reveal the problem better.

<snip>

> I think you simply want to trigger the soft-bdflush event earlier, with
> -aa something like this may do the trick:
>
> echo 5 500 64 256 500 3000 60 2 0 > /proc/sys/vm/bdflush
>
> this way you'll wakeup as soon as 5% of the 118mbytes (+ free memory,
> none in this case) are dirty, and bdflush will stop as soon as the level
> is back to 2% (then kupdate will take care of the 2%). Those suggested
> values may be too strict but this way you should get the idea if it
> helps somehow or not :)

Thanks for the idea. Unfortunately, it didn't help. :(

Blocks definitely do begin hitting the disk much sooner after I begin the
transfer, but the overall time is basically unchanged: 7:08. vmstat still shows
the widely oscillating bo value.

--Adam



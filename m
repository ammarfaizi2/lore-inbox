Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290558AbSARA3c>; Thu, 17 Jan 2002 19:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290557AbSARA3X>; Thu, 17 Jan 2002 19:29:23 -0500
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:38129 "EHLO
	filestore.kroptech.com") by vger.kernel.org with ESMTP
	id <S290556AbSARA3F>; Thu, 17 Jan 2002 19:29:05 -0500
Message-ID: <012a01c19fb7$1f39d580$02c8a8c0@kroptech.com>
From: "Adam Kropelin" <akropel1@rochester.rr.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "Rik van Riel" <riel@conectiva.com.br>
In-Reply-To: <20020116200459.E835@athlon.random> <056c01c19ed4$f0e77300$02c8a8c0@kroptech.com> <20020117151745.H4847@athlon.random>
Subject: Re: async buffer flushing reported slowdown (could be a driver issue?)
Date: Thu, 17 Jan 2002 19:28:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 18 Jan 2002 00:28:59.0481 (UTC) FILETIME=[1F39FC90:01C19FB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Wed, Jan 16, 2002 at 04:29:54PM -0500, Adam Kropelin wrote:
> > Andrea Arcangeli wrote:
> > <snip>
> > >I don't have a single bugreport about the current 2.4.18pre2aa2 VM (except
> > >perhaps the bdflush wakeup that seems to be a little too late and that
deals to
> > >lower numbers with slow write load etc.., fixable with bdflush tuning).
> >
> > As reported[0] in the above-mentioned thread, the bdflush tuning parameters
> > you suggested made no difference in my test case other than slightly
adjusting
> > the temporal relationship between writeout and file transfer. -aa still
performs
> > slightly worse than both 2.4.17 stock and -rmap. 2.4.13-ac7 currently beats
> > all competitors.
>
> Then can you verify the bandwith you get out of the network card is the
> same across 2.4.13-ac7 and all the other kernels you are trying. Also

I'll check that and get back to you.

> please check with an hdparm -t the speed you get out of IDE is the same.

There is no IDE in the system. The destination for the file transfer is on
cpqarray RAID5. Do you have a recommendation for how I test the transfer rate of
that without stressing the VM?

> This sounds like some driver changed (note that -ac is used to queue
> lots of driver updates) and that made the difference. Otherwise if we
> wakeup bdflush early enough I don't see why it takes more time.

One of my original tests[0] was to take the cpqarray update from -ac and bring
it forward to 2.4.17. I saw about 20 sec improvement with that, still not
competitive overall with -ac performance. I'll try doing the same with eepro
driver, which is the NIC I'm using.

--Adam

[0]
http://www.kroptech.com:8300/mailimport/showmsg.php?msg_id=49714&db_name=linux_k
ernel



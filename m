Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSIEVXJ>; Thu, 5 Sep 2002 17:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318133AbSIEVXJ>; Thu, 5 Sep 2002 17:23:09 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:54011 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318085AbSIEVXI>; Thu, 5 Sep 2002 17:23:08 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 5 Sep 2002 15:25:16 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Peter Surda <shurdeek@panorama.sth.ac.at>, linux-kernel@vger.kernel.org
Subject: Re: Uptime timer-wrap
Message-ID: <20020905212516.GN7887@clusterfs.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Peter Surda <shurdeek@panorama.sth.ac.at>,
	linux-kernel@vger.kernel.org
References: <20020905180253.GC2567@noir.cb.ac.at> <Pine.LNX.3.95.1020905160808.141A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020905160808.141A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 05, 2002  16:16 -0400, Richard B. Johnson wrote:
> I tried to simulate your observation by making a driver that
> set the 'jiffies' count upon an 'open'. The idea was to get
> the jiffies count to something close to wrap so I didn't have to
> wait a long time.
> 
> Anyway, I found that setting the jiffies count to more than a
> few hundred counts into the future, causes the machine to halt
> with no interrupts (no Capslock, no NumLock, no network ping, etc).
> 
> The machine just stops and I don't understand why. 
> 
> 
> 	spin_lock_irqsave(&xlock, flags);
>         jiffies += 0x1000;
> 	spin_lock_irqrestore(&xlock, flags);
> 
> 	... works just fine, but, changing 0x1000 to 0x7fffffff causes
> the machine to stop as reported. 
> 
> Does anybody have a clue?

Yes, because now some kernel code is going to wait 147 days - 1s
or something like that to finish.

See Tim Schmielau <tim@physik3.uni-rostock.de> patch for testing jiffies
wrap.  It _initializes_ jiffies to a high pre-wrap value, maybe 5
minutes before wrap, instead of playing around with the jiffies value
after the system is running.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/


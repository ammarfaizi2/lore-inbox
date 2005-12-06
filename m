Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVLFCAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVLFCAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLFCAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:00:54 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:45763 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S964909AbVLFCAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:00:53 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andy Isaacson <adi@hexapodia.org>
Cc: Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051206014720.GN22168@hexapodia.org>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
	 <1133791084.3872.53.camel@laptop.cunninghams>
	 <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost>
	 <20051206013759.GI1770@elf.ucw.cz>  <20051206014720.GN22168@hexapodia.org>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133834245.3896.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 06 Dec 2005 11:57:26 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy.

On Tue, 2005-12-06 at 11:47, Andy Isaacson wrote:
> On Tue, Dec 06, 2005 at 02:37:59AM +0100, Pavel Machek wrote:
> > > desktop here at work, for example, writes the image at 72MB/s and reads
> > > it back at 116MB/s. (3GHz P4 with a Maxtor 6Y120L0). Writing 1GB at
> > > these rates is not a problem.
> 
> Hmm, I only wish...
> 
> > Andy reported 20MB/sec on hdparm. I do not think it is possible to
> > write faster than that. And that seems about ok for notebooks, X32
> > (pretty new) has:
> > 
> > root@amd:~# hdparm -t /dev/hda
> 
> You named your X32 "amd"?  How ... confusing ... (assuming it, like all
> other Thinkpad X series I know, has a Pentium M.)
> 
> > /dev/hda:
> >  Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec
> 
> That's quite a bit better than mine, and I am pretty sure I am the same
> vintage or newer (purchased this summer), but I'm getting barely half
> that speed:
>  Timing buffered disk reads:   58 MB in  3.10 seconds =  18.70 MB/sec
> 
> How can I find out what disk is in this beast and try to track down some
> of my missing performance?  It looks like I have the right DMA settings
> and whatnot looking at hdparm(1).

What RPM does the drive spin at? Using hdparm -I to get the model
number, then Google to get the specs. If it's like most laptop HDDs, it
probably only spins at 4200RPM. My original drive in my Omnibook was
like that - 4200RPM, ATA66. The best it would do (according to hdparm
-t) was about 17 or 18MB/s raw. Pavel's better numbers are the same as
what I get in my laptop now, with a 7200RPM drive. Here ATA66 appears to
have become the limiting factor, so that I get about 35 or 36MB/s too.
The desktop drive I mentioned above is ATA133, and does about 56MB/s
raw. The higher numbers above (72/116) come from having a fast cpu
(de)compressing.

In my case, because my hard drive is fast, I don't gain much from
compressing the image. I actually write is slower while compressing, and
get a bit of a gain while uncompressing. In your case though, since your
harddrive is slower, you'll benefit more from compressing the image,
getting closer to the doubling that we've spoken of before. (Doubling
coming from the compression ratio that LZF achieves generally being
around 50%).

Hope this helps.

Nigel.


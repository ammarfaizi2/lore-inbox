Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315384AbSEBT6f>; Thu, 2 May 2002 15:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315386AbSEBT6e>; Thu, 2 May 2002 15:58:34 -0400
Received: from unthought.net ([212.97.129.24]:1685 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S315384AbSEBT6e>;
	Thu, 2 May 2002 15:58:34 -0400
Date: Thu, 2 May 2002 21:58:33 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
Message-ID: <20020502215833.V31556@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Pavel Machek <pavel@suse.cz>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204301746020.2301-100000@mustard.heime.net> <20020426152943.A413@toy.ucw.cz> <3CD18318.7060407@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 08:19:04PM +0200, Martin Dalecki wrote:
...
> 15 drives == 16 interfaces == 8 channels == 4 controllers
> with primary and secondary channel.

Usually using both master and slave on an IDE channel spells disaster
performance wise, and I would be surprised if the hotplug stuff worked
with this as well...

> 
> He will have groups of about 4 drives on each channel wich
> serialize each other due to excessive IRQ line sharing and
> master slave issues.

Use 8 controllers for the 15 (16) drives.

> 
> 8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
> a classical RAID controller card for this kind of
> setup.

Because RAID controllers do not use the PCI bus ???    ;)

The bus-overhead on RAID-5 is not too bad unless you specifically construct
a workload to make it so (writes-only, scattered so that the kernel cannot
cache stripes to avoid read-in for parity calculation).

Sure, the PCI bus will be a bottleneck, and PCI overhead alone will decrease
the real-world performance to somewhere below the theoretical PCI bandwidth
limitations, but don't let this blind you  -  100 MB/sec sustained transfers
can still be "good enough" for many people.

By the way, has anyone tried such larger multi-controller setups, and tested
the bandwidth in configurations with multiple PCI busses on the board, versus a
single PCI bus ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133040AbRD3RWc>; Mon, 30 Apr 2001 13:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135170AbRD3RWW>; Mon, 30 Apr 2001 13:22:22 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:32700 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S133040AbRD3RWG>; Mon, 30 Apr 2001 13:22:06 -0400
Date: Mon, 30 Apr 2001 19:22:01 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        Ralf Nyren <ralf@nyren.net>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.4: Kernel crash, possibly tcp related
Message-ID: <20010430192201.A3305@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.31.0104291552190.523-100000@HADDOCK.100Mbit.nyren.net> <15084.62398.56283.772414@pizda.ninka.net> <3AED0A7A.7263E27B@uow.edu.au> <15085.3340.784923.77844@pizda.ninka.net> <20010430184633.B19620@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010430184633.B19620@athlon.random>; from andrea@suse.de on Mon, Apr 30, 2001 at 06:46:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 06:46:33PM +0200, Andrea Arcangeli wrote:
> On Sun, Apr 29, 2001 at 11:58:20PM -0700, David S. Miller wrote:
> > Andrew Morton writes:
> >  > "David S. Miller" wrote:
> > Anyways, I just tried to reproduce Ralf's problem on two of my
> > machines.  One was an SMP sparc64 system, and the other was my
> > uniprocessor Athlon.
> > 
> > What kind of machine are you reproducing this on Ralf?  I'm not
> 
> JFYI: I reproduced too on my UP athlon. I run:
> 
> 	tcpblast -d0 -s 40481 another_host 9000
> 
> two times and after the second it locked hard. I didn't had any fork
> bomb at the same time but there was an high computing load in the
> background.

I tried sth. else with 2.4.3-ac13, which could be related:

Machine: 1GB RAM, Dual PIII, ServerWorks LE chipset (Asus CUR-DLS board). 
NIC: [Ethernet Pro 100] (rev 08) (driven by eepro100)

0. Run several kernel compiles and the like to fill up caches.
1. copy an complete iso image into /tmp (which is tmpfs)
2. ftp that over 100Mbit network to an machine.

I got a lot of spikes and a message "mm: critical shortage of
bounce buffers", while doing 1.

And I get a LOT of that messages, while doing 2. But I have a lot
of memory in pagecache and only 100MB allocated for other
processes. And I still have swap free (I have 2GB of swap as
recommended).

So could we please check, double check and triple check the
allocations in the net layer?

Another machine of mine needs now 128MB with the new kernel and
will lock up hard otherwise on full saturated 100Mbit network
load[1] with TCP, but needed only 32MB before. sth. has to be
wrong here...

More info on request. 

I have both machines at hand and they are both ready for testing
as long, as my file systems stay repairable by fsck.ext2 ;-)

Both machines are not running X, frame buffers and no fancy multi
media stuff.

Regards

Ingo Oeser

[1] Tested cards: RTL 8139, Intel Etherexpress Pro 100, 3com
   3c509TX, so I guess it's NOT the NIC ;-)
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>

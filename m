Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUFTOow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUFTOow (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUFTOoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:44:30 -0400
Received: from pdbn-d9bb9eb6.pool.mediaWays.net ([217.187.158.182]:61964 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S265886AbUFTOng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:43:36 -0400
Date: Sun, 20 Jun 2004 16:43:32 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Jens Axboe <axboe@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.6 & 2.6.7 sometime hang after much I/O
Message-ID: <20040620144332.GB28338@citd.de>
References: <Pine.LNX.4.44.0406201123240.26522-100000@korben.citd.de> <40D56700.2030206@yahoo.com.au> <20040620115908.GA27241@citd.de> <40D58B93.4040304@yahoo.com.au> <20040620141734.GA28048@citd.de> <20040620141936.GA14787@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620141936.GA14787@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 04:19:39PM +0200, Jens Axboe wrote:
> On Sun, Jun 20 2004, Matthias Schniedermeyer wrote:
> > On Sun, Jun 20, 2004 at 11:05:23PM +1000, Nick Piggin wrote:
> > > Matthias Schniedermeyer wrote:
> > > 
> > > >Here we go.
> > > >
> > > >Addendum: After some time more and more konsole froze. Up to the point
> > > >where i (had to) kill(ed) X(CTRL-ALT-Backspace) and after i couldn't
> > > >even log in at the console anymore i rebooted (into 2.6.5). Then i
> > > >recompiled 2.6.7 with SYSRQ-support and tried to reproduce the hanging
> > > >without X. After 3 runs i "gave up" and started X. Here i had luck and
> > > >the process ('cut-movie.pl') froze at first try. Then i killed X and did
> > > >the above on the console.
> > > >
> > > >As the system is currently unsuable enough to reboot, i will reboot in
> > > >2.6.5 after this mail, but i can always reboot into 2.6.7 if you need
> > > >more input.
> > > >
> > > >
> > > 
> > > The attached trace was with 2.6.7, right?
> > 
> > Yes.
> > 
> > > Can you reproduce the hang, then, as root, do:
> > > 
> > > 	echo 1024 > /sys/block/sda/queue/nr_requests
> > > 
> > > Replace sda with whatever devices your hung processes were
> > > doing IO to. Do things start up again?
> > 
> > 1 try (with X) with unchanged nr_requests. (I was stupid enough to issues the
> > command on the wrong HDD :-) )
> > (AFAIR i had the same situation with 2.6.6, sometimes the hang didn't happen)
> > 
> > 6 tries (with X) with nr_requests=1024 and no hang.
> > 
> > 1 try with nr_requests back to 128 and now it hangs.
> > now changing to nr_request=1024 doesn't seem to change anyting, my
> > konsoles start to freeze.
> > 
> > 
> > Don't know if it is relevant but the bytes transfered are always rougly
> > around 3000-3400MB (1500-1700 MB read & 1500-1700 MB write. The program
> > reads 100MB, then writes 100MB, then issues "sync", the hangs happend
> > always about every after 15-17 "rounds")
> 
> (missed the initial report) - what io hardware are you using?

The data-HDD is connected via a Highpoint-RocketRAID 1540, HPT-374
chipset. The cable-connection is via double S-ATA <-> P-ATA adapters.
(The RocketRAID has the adapters onboard and the HDD has another one.

My system-HDD is a SCSI one, connected via Symbios 53c1010 (Dual U160)
As i can't even start new programs and running programms freeze one
after the other and none has ANY I/O with the data-HDD i would suspect
the Symbios more than the Highpoint.



Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTEEQgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTEEQg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:36:27 -0400
Received: from ns.suse.de ([213.95.15.193]:46598 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262220AbTEEQe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:34:56 -0400
Date: Mon, 5 May 2003 18:46:53 +0200
From: Karsten Keil <kkeil@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: alan@lxorguk.ukuu.org.uk, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: ISDN massive packet drops while DVD burn/verify
Message-ID: <20030505164653.GA30015@pingi3.kke.suse.de>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	alan@lxorguk.ukuu.org.uk, kai@tp1.ruhr-uni-bochum.de,
	linux-kernel@vger.kernel.org
References: <20030416151221.71d099ba.skraw@ithnet.com> <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu> <20030419193848.0811bd90.skraw@ithnet.com> <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk> <20030505142300.GC28010@pingi3.kke.suse.de> <20030505173249.50a72df9.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030505173249.50a72df9.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.20-4GB i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 05:32:49PM +0200, Stephan von Krawczynski wrote:
> On Mon, 5 May 2003 16:23:00 +0200
> Karsten Keil <kkeil@suse.de> wrote:
> 
> > Hi Stephan,
> 
> Hi Karsten,
> 
> long time no hear ;-)
> 

Yes.

> > > Sorry Alan, "been there, done that"
> > > I made ISDN work on just about anything that you would call an OS on
> > > sometimes quite ancient hardware (compared to nowadays), and I really
> > > cannot imagine that the combined (though sometimes confusing) efforts of
> > > you, Andre, Pavel, name-one on IDE made a dual 1.4 GHz PIII slower
> > > (responding) than a M68k 7,14 MHz with a polling IDE interface - which
> > > happens to be the slowest thing I ever did ISDN programming on
> > > _flawlessly_.
> > > 
> > 
> > No Alan and Kai are right.
> > 
> > The problem with the Infineon ISDN chips is that the fifos are small and so
> > IRQ latency is relativ critical. 32 or 64 bytes are only 4/8 ms, and if one
> > of these 32 Byte is dropped, the complete frame is lost. Modern ethernet
> > cards allways have fifos for multiple complete frames, so that such things
> > don't happen here.
> 
> I know the relatively small fifos. On the other hand compared to the ridiculous
> throughput of 8 kByte/sec (single channel) (which most people seem to ignore in
> this discussion), it is ok.

Again, the throughput doesn't matter so much.
The problem is latency and fifo size.
You lost a complete frame of 1500 Byte if one IRQ is missed and you need
about 46 IRQ per 1500 byte frame. So if you only miss 1% of RX IRQ, you
loose 33% of you troughput (every 3. frame).
On a High Speed Ethernet controller with 1% IRQ loss you don't see a effect,
since you loose also only 1%.
Thats why throughput doesn't matter in this case.

> 
> Let me simply ask back: is the IDE code in nowadays 2.4 kernel so bad, that a
> dual 1,4 GHz PIII cpu with 3 GB ram performs much worse than a 90 MHz P I with
> 64 MB and OS/2 on it???
> _My_ isdn drivers showed _no_ such problems under OS/2 and IDE load...
> 
> How did we manage to become that bad?

Its not so bad, the problem is how do you tune the system. If you prefer to
not interrupt the IDE transfers, which seems to be the default case, you
loose IRQ latency, which doesn't matter in much cases, but not on
this. You can tune it (hdparm work also with cdwriters, since
even if it use ide-scsi, the underlying driver is the ide driver.


> 
> > You can try to use HFC based ISDN cards (e.g. Conrad: ISDN TA 128K) the
> > fifos are much bigger (7.5kB) so at least 4 complete 1500 byte frames can be 
> > handled without segmentation. That increase the IRQ latency a lot (~900 ms).
> 
> I know HFC is nice. But that cannot mean ISAC/HSCX must have dropouts. You have
> to have long interrupt lock outs for such a behaviour, which cannot be intended
> at all.

Yes at least you must have 4+x ms interrupt lock outs, I didn't meassure it,
but reports show that hdparm -u1 helps in much cases. Note enabling IRQ
don't say that now the ISDN IRQ will handled, here maybe other IRQs with
higher priority which are served first and add extra latency.

This all don't say that here maybe also other problems around, but I have no
better explanation.

> 
> -- 
> Regards,
> Stephan

-- 
Karsten Keil
SuSE Labs
ISDN development

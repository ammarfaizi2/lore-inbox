Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUGZUOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUGZUOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUGZUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:14:51 -0400
Received: from mail.convergence.de ([212.84.236.4]:18580 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264577AbUGZT3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:29:05 -0400
Date: Mon, 26 Jul 2004 21:29:39 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Rudo Thomas <rudo@matfyz.cz>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: max request size 1024KiB by default?
Message-ID: <20040726192939.GA3689@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Lee Revell <rlrevell@joe-job.com>, Rudo Thomas <rudo@matfyz.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu> <20040720121905.GG1651@suse.de> <1090642050.2871.6.camel@mindpipe> <1090647952.1006.7.camel@mindpipe> <20040724112706.GA31077@ss1000.ms.mff.cuni.cz> <1090709881.1194.28.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090709881.1194.28.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2004 at 06:58:02PM -0400, Lee Revell wrote:
> On Sat, 2004-07-24 at 07:27, Rudo Thomas wrote:
> > > HD info:
> > > /dev/hdc:
> > > 
> > >  Model=Maxtor 6Y160P0, FwRev=YAR41BW0, SerialNo=Y44K8TZE
> > >  Config={ Fixed }
> > >  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
> > >  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
> > >  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=268435455
> > >  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> > >  PIO modes:  pio0 pio1 pio2 pio3 pio4 
> > >  DMA modes:  mdma0 mdma1 mdma2 
> > >  UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
> > >  AdvancedPM=yes: disabled (255) WriteCache=enabled
> > >  Drive conforms to: (null): 
> > 
> 
> Your disk controller must not support that.  It looks like the default
> is 1024KiB or whatever the max your controller supports is:

For drives smaller than 128GiB the "48-bit Address feature set" is optional,
hence many older drives do not support it (since the old 28-bit LBA
addressing is suffient).

With 28-bit addressing the number sectors which can be transferred
in one request is limited to 256. Linux 2.4 limited this further
to 128 (i.e. 64KiB). With 48-bit addressing up to 2^16 sectors
could be transferred in one request, but Linux 2.6 puts an arbitrarily
chosen limit of 1024KiB on it.

'hdparm -I /dev/hda' will tell you whether your drive supports
48-bit addressing:

  Commands/features:
	Enabled	Supported:
	   *	48-bit Address feature set 

For full details see the ATA/ATAPI-7 spec at http://www.t13.org/.

Johannes

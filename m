Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268410AbTBWRTS>; Sun, 23 Feb 2003 12:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268471AbTBWRTS>; Sun, 23 Feb 2003 12:19:18 -0500
Received: from mail.ithnet.com ([217.64.64.8]:26636 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S268410AbTBWRTP>;
	Sun, 23 Feb 2003 12:19:15 -0500
Date: Sun, 23 Feb 2003 18:29:14 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030223182914.0fd9947d.skraw@ithnet.com>
In-Reply-To: <1046012671.1964.2.camel@laptop.fenrus.com>
References: <20030202153009$2e0d@gated-at.bofh.it>
	<20030205181006$107c@gated-at.bofh.it>
	<20030205181006$7bb8@gated-at.bofh.it>
	<20030205181006$455c@gated-at.bofh.it>
	<20030205181006$5dba@gated-at.bofh.it>
	<20030205181006$3358@gated-at.bofh.it>
	<200302061451.h16Epl0Z001134@pc.skynet.be>
	<20030223153316.262a201e.skraw@ithnet.com>
	<1046012671.1964.2.camel@laptop.fenrus.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Feb 2003 16:04:31 +0100
Arjan van de Ven <arjan@fenrus.demon.nl> wrote:

> On Sun, 2003-02-23 at 15:33, Stephan von Krawczynski wrote:
> > On Thu, 06 Feb 2003 15:51:47 +0100
> > Hans Lambrechts <hans.lambrechts@skynet.be> wrote:
> > 
> > > Stephan von Krawczynski wrote:
> > > 
> > > <---snip--->
> > > 
> > > > 
> > > >            CPU0       CPU1
> > > >   0:      71158          0    IO-APIC-edge  timer
> > > >   1:        941          0    IO-APIC-edge  keyboard
> > > >   2:          0          0          XT-PIC  cascade
> > > >  12:      33166          0    IO-APIC-edge  PS/2 Mouse
> > > >  15:          4          0    IO-APIC-edge  ide1
> 
> <snip>
> 
> > I am sorry, but this patch is:
> > a) already included in 2.4.21-pre4 (which I run)
> > b) does therefore obviously not help
> > 
> > Any other suggestions? 
> 
> could you give the irqbalance daemon from
> 
> http://people.redhat.com/arjanv/irqbalance/irqbalance-0.06.tar.gz
> 
> a try ?

Hella Arjan,

I tried it and it looks as if it performs as expected:

           CPU0       CPU1       
  0:    1288917      35375    IO-APIC-edge  timer
  1:       8917        244    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 12:     350644        552    IO-APIC-edge  PS/2 Mouse
 15:          6          0    IO-APIC-edge  ide1
 17:     426082       7881   IO-APIC-level  ide2, ide3
 18:     329936        919   IO-APIC-level  eth0, eth1
 20:         43          0   IO-APIC-level  aic7xxx
 21:   10439503          0   IO-APIC-level  eth2
 22:    1596851     122119   IO-APIC-level  aic7xxx
 23:         16          0   IO-APIC-level  aic7xxx
 25:       1304         36   IO-APIC-level  HiSax
 26:          0          0   IO-APIC-level  EMU10K1
NMI:          0          0 
LOC:    1324228    1324203 
ERR:          0
MIS:          0

Within a few minutes I see the above. The only thing left: I am not able to
produce interrupts from eth2 (tg3) on CPU1. I have not looked at the daemons
policies so far, so maybe this is normal...
It looks interesting. Did you decribe it somewhere?
-- 
Regards,
Stephan


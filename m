Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRDUM6f>; Sat, 21 Apr 2001 08:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRDUM6Z>; Sat, 21 Apr 2001 08:58:25 -0400
Received: from supelec.supelec.fr ([160.228.120.192]:61457 "EHLO
	supelec.supelec.fr") by vger.kernel.org with ESMTP
	id <S132586AbRDUM6L>; Sat, 21 Apr 2001 08:58:11 -0400
Message-ID: <3AE183B7.1DD88174@supelec.fr>
Date: Sat, 21 Apr 2001 14:57:27 +0200
From: Francois Cami <francois.cami@supelec.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [3C905x e401]
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEHBGDAA.vhou@khmer.cc> <3ADFA34D.80D8BEE9@supelec.fr> <3AE0E1B5.2C8318A7@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


okay, testing will begin monday (when it's under load).
any advice on which value i begin with ? (20 ?)

François Cami


Andrew Morton wrote:
> 
> Francois Cami wrote:
> >
> > Vibol Hou wrote:
> > ...
> >
> > > Apr 17 16:10:12 omega kernel: eth0: Too much work in interrupt, status e401.
> >
> > I got that one too, PC is ASUS P2B-DS with two PII-350, 384MB RAM,
> > 3C905B.
> 
> If you were getting this message occasionally, and if increasing the
> max_interrupt_work module parm makes it stop, and everything
> is always working fine, then it's an OK thing to do.
> 
> Question is: why is it happening?  We're failing to get out
> of the interrupt loop after 32 loops.  Each loop can reap
> up to 16 transmitted packets and 32 received packets.
> That's a lot.
> 
> My suspicion is that something else in the system is
> causing the NIC interrupt routine to get held up for long
> periods of time.  It has to be another interrupt.
> 
> All reporters of this problem (ie: both of them) were using
> aic7xx SCSI.  I wonder if that driver can sometimes spend a
> long time in its interrupt routine.  Many times.  Rapidly.
> 
> Very odd.
> 
> Ah.  SMP.  Perhaps the other CPU is generating the transmit
> load, some other interrupt source is slowing down *this*
> CPU.
> 
> Could you test something for me?  Try *decreasing* the
> value of max_interrupt_work.  See if that increases
> the frequency of the message.  Then, it if does, try to
> correlate the occurence of the message with some other
> form of system activity (especially disk I/O).
> 
> Thanks.
> 
> -

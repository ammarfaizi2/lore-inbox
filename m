Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbTBBRmo>; Sun, 2 Feb 2003 12:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTBBRmo>; Sun, 2 Feb 2003 12:42:44 -0500
Received: from mail.ithnet.com ([217.64.64.8]:51214 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S265093AbTBBRmn>;
	Sun, 2 Feb 2003 12:42:43 -0500
Date: Sun, 2 Feb 2003 18:52:05 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.21-pre4: tg3 driver problems with shared interrupts
Message-Id: <20030202185205.261a45ce.skraw@ithnet.com>
In-Reply-To: <3E3D4C08.2030300@pobox.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Feb 2003 11:49:12 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Stephan von Krawczynski wrote:
> > I found out within minutes that this setup does not survive if you let the
> > Broadcom cards share interrupts with anything else. It works ok now like
> > this (eth2 is tg3):
> 
> [...]
> > But horribly failed in such a setup:
> 
> [...]
> > I cannot even produce a "cat /proc/interrupts" for this because I am not
> > fast enough at login (the network at eth2 is heavy loaded). I sometimes
> > read about problems here with tg3-drivers, and I just wanted to point you
> > to the shared case, maybe it has to do with this special case rather than
> > with the drivers internals itself.
> > (PS: its not the ide2-3, I checked that out)
> 
> 
> 
> hmmm.  I've attached the latest tg3, version 1.4, which I just sent off 
> to Marcelo.  It includes some fixes that may affect your 5701.
> 
> Can you try two things?
> 
> 1) 2.4.21-pre4 + tg3 v1.4

Ok. With the latest version you sent I got it compiled and working. As far as I
can tell from short tests it looks good (eth2 is tg3):

           CPU0       
  0:      79344          XT-PIC  timer
  1:       2428          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  EMU10K1
  7:         81          XT-PIC  HiSax
  9:     387286          XT-PIC  aic7xxx, aic7xxx, eth0, eth1, eth2
 11:      75780          XT-PIC  ide2, ide3
 12:      17740          XT-PIC  PS/2 Mouse
 15:          2          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

To make sure I will let it stress-test overnight and send you the results in
about 15 hours from now on. If everything does fine I will redo with ide2,ide3
on same interrupt, too. Just to see what happens with these Promise things...

-- 
Thanks a lot, I'll be back,
Stephan

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbTHZE1v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTHZE1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:27:51 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:26539 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262541AbTHZE1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:27:46 -0400
Date: Tue, 26 Aug 2003 16:21:19 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: 2.4.22 hangs with pcmcia and linux-wlan
In-reply-to: <20030826041116.GI734@alpha.home.local>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Hmamouche, Youssef" <youssef@ece.utexas.edu>,
       Christian Hesse <news@earthworm.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1061871679.3327.11.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.21.0308252234010.25458-100000@linux08.ece.utexas.edu>
 <1061869538.2790.9.camel@laptop-linux> <20030826041116.GI734@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bingo.

[root@laptop-linux src]# cat /proc/interrupts 
           CPU0       
  0:     342407          XT-PIC  timer
  1:       9083          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:     509112          XT-PIC  ltserial
  5:        414          XT-PIC  usb-uhci, usb-uhci, Allegro
  8:          1          XT-PIC  rtc
  9:       1322          XT-PIC  acpi, usb-uhci, i82365
 10:       1623          XT-PIC  eth0
 12:     284866          XT-PIC  PS/2 Mouse
 14:     104489          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0 
LOC:     342373 
ERR:          0
MIS:          0
[root@laptop-linux src]#

Now I just need to learn how to get it to assign a different IRQ.

Regards,

Nigel

On Tue, 2003-08-26 at 16:11, Willy Tarreau wrote:
> Hi,
> 
> I already encountered similar problems.
> 
> Check if the PCMCIA slot is not on the same IRQ as ACPI in /proc/interrupts. You
> can also try to use a different PCMCIA slot, or boot with "acpi=off".
> 
> Cheers,
> Willy
> 
> On Tue, Aug 26, 2003 at 03:45:52PM +1200, Nigel Cunningham wrote:
> > Hi.
> > 
> > Similar results here, except I can be more specific. I see the issue
> > using pcmcia only. The package I'm using is the
> > external-to-the-kernel-tree pcmcia-cs-3.2.3. Under 2.4.22, I get a
> > complete freeze (no SysRq, no flashing cursor) when I insmod i82365.o. I
> > tried recompiling the whole kernel & modules using gcc 2.96 and 3.2 to
> > no avail.  If I use the kernel tree's code, I can insmod okay, but my
> > ltmodem_cs driver reports the modem as being busy all the time. The
> > problem was fixed by reverting to 2.4.21 (I'd already deleted pre2,
> > which was working). No configuration changes required - just a
> > recompile.
> > 
> > Regards,
> > 
> > Nigel
> > 
> > On Tue, 2003-08-26 at 15:37, Hmamouche, Youssef wrote:
> > > Out of curiosity, what happens when you remove the card? Does the system
> > > come back to normal or does it stay in the same state?
> > > 
> > > Youssef
> > > 
> > > On Tue, 26 Aug 2003, Christian Hesse wrote:
> > > 
> > > > Hi,
> > > > 
> > > > I'm running kernels with pcmcia-cs-3.2.4 and linux-wlan-ng-0.2.1-pre11 (also 
> > > > tried 0.2). With 2.4.22-rc3 to final the system hangs if I insert my LevelOne 
> > > > WPC-0100 (Prism-II-base wlan), no output at all. Everything worked well up to 
> > > > and including 2.4.22-rc2.
> > > > 
> > > > Regards,
> > > >   Christian
> > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > -- 
> > Nigel Cunningham
> > 495 St Georges Road South, Hastings 4201, New Zealand
> > 
> > You see, at just the right time, when we were still powerless,
> > Christ died for the ungodly.
> > 	-- Romans 5:6, NIV.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.


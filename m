Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTI3Jo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbTI3Jo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:44:58 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:1549 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261271AbTI3Joz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:44:55 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
Subject: Re: USB problem. 'irq 9: nobody cared!' (FIXED!)
Date: Tue, 30 Sep 2003 11:41:18 +0200
User-Agent: KMail/1.5.3
Cc: Milton Miller <miltonm@bga.com>, linux-kernel@vger.kernel.org
References: <200309242257.h8OMvR5d090443@sullivan.realtime.net> <20030925180020.GB28876@kroah.com> <3F733DF1.7010008@pacbell.net>
In-Reply-To: <3F733DF1.7010008@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309301141.18595.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 of September 2003 21:11, David Brownell wrote:

> The problem is that nobody has ever reported back with results from
> testing any updated patch (see attachment, the guts of this being
> from Alan Stern).  Sort of makes trying be a moot point ... :)
So I'm the first one? ;)

Your patch (http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0341.html) 
FIXES things for me :-)

This time I've tried 2.6.0test6 + all acpi patches from 2.6.0-mm1 (ls *acpi* 
in akpm broken-out directory) + your patch and things work fine :)
Note that 2.6.0+all acpi patches from 2.6.0-mm1 without your patch doesn't 
work.

[arekm@mobarm arekm]$ cat /proc/interrupts
           CPU0
  0:     698946          XT-PIC  timer
  1:       1712          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:       1561          XT-PIC  irda0
  5:          4          XT-PIC  yenta
  8:          0          XT-PIC  rtc
  9:       2657          XT-PIC  acpi, eth0
 10:      77708          XT-PIC  VIA686A, uhci-hcd, uhci-hcd
 12:         18          XT-PIC  i8042
 14:      12408          XT-PIC  ide0
 15:         20          XT-PIC  ide1
NMI:          0
ERR:          0

More details about my case in lkml archives and 
http://bugme.osdl.org/show_bug.cgi?id=905

> It's OK with me if you just revert the patch that adds a uhci_reset()
> entry, but based on what I saw with EHCI and OHCI that'll just turn
> up a different set of problems with certain BIOS configurations (none
> of which I have) ... which will need to be fixed by having a UHCI
> reset sequence that works correctly from _all_ initial states.
>
> - Dave

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUFQRhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUFQRhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUFQRhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 13:37:17 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:4300 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S261231AbUFQRhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 13:37:08 -0400
Message-ID: <40D1D6BD.4050505@ThinRope.net>
Date: Fri, 18 Jun 2004 02:37:01 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI vs. APM - Which is better for desktop and why?
References: <Pine.LNX.4.60.0406171308080.17891@p500>
In-Reply-To: <Pine.LNX.4.60.0406171308080.17891@p500>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> I have enabled ACPI on my Dell GX1 (Pentium 3/500MHZ) machine and 
> disabled APM, however, what are the benefits of using ACPI over APM?
> 
> I am using Kernel 2.6.7
> 
> I see ACPI eats up an IRQ and does not share it:
> 
> $ cat /proc/interrupts
>            CPU0
>   0:   64997374          XT-PIC  timer
>   1:         10          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:       2625          XT-PIC  Crystal audio controller
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:     277489          XT-PIC  ide2
>  11:   11465050          XT-PIC  ide4, ide5, eth0, eth1, eth2, eth3
>  12:         58          XT-PIC  i8042
>  14:     307536          XT-PIC  ide0
>  15:         53          XT-PIC  ide1
> NMI:          0
> LOC:   65007290
> ERR:          0
> MIS:          0
> 
Yep, IRQ 11 is a bit crowded...

I was just about to ask a similar question...
How do I have a better interrupt table (no or less shared intrerupts) with ACPI?

My system (just rebooted) says:
 $ cat /proc/interrupts 
           CPU0       
  0:    1434691    IO-APIC-edge  timer
  1:       5158    IO-APIC-edge  i8042
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       8097    IO-APIC-edge  ide0
 15:        959    IO-APIC-edge  ide1
 19:     105118   IO-APIC-level  nvidia
 20:      17455   IO-APIC-level  ehci_hcd, eth0, NVidia nForce2
 21:          0   IO-APIC-level  ohci_hcd
 22:      16156   IO-APIC-level  ohci_hcd
NMI:          0 
LOC:    1434624 
ERR:          0
MIS:          0

The "problem" here might be IRQ 20 when I am using my scanner@4800dpi (USB2.0, Epson GT-X700) writing the output via NFS (through eth0). Will test the numbers some other time.

Kalin.


-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWBMKGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWBMKGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWBMKGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:06:17 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:31753 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751697AbWBMKGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:06:16 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: 2.6.16-rc2, x86-64, CPU hotplug failure
Date: Mon, 13 Feb 2006 10:06:23 +0000
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
References: <200602130230.41120.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0602122223290.10777@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0602122223290.10777@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 2253
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602131006.23819.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 07:05, Zwane Mwaikambo wrote:
> On Mon, 13 Feb 2006, Alistair John Strachan wrote:
> > In an attempt to play with ACPI S3 on my Athlon 64 X2 3800+, I recompiled
> > 2.6.16-rc2 with CPU hotplug and ACPI sleep state support. I experienced
> > multiple crashes and oopsen, which I quickly discovered were the result
> > of bringing at least one CPU back online.
> >
> > echo 0 >> /sys/devices/system/cpu/cpu1/online
> >
> > Works, but then if I try to do:
> >
> > echo 1 >> /sys/devices/system/cpu/cpu1/online
> >
> > I get an oops. Unfortunately this board has no serial ports so I've taken
> > a digital camera shot of the oops. From dmesg, I'm using the PM timer.
> >
> > [alistair] 02:13 [~] dmesg | egrep time\.c
> > time.c: Using 3.579545 MHz PM timer.
> > time.c: Detected 2500.768 MHz processor.
> > time.c: Using PM based timekeeping.
> >
> > http://devzero.co.uk/~alistair/oops-20060213/
>
> Nice snapshot, that bug was fixed around 2.6.16-rc3, unsynchronized_tsc
> was marked __init instead of __cpuinit

Thanks Zwane, everything's working now. I guess I should have upgraded when I 
read the announcement.

On the ACPI front, both standby and mem seem to work (S1 and S3 I assume), in 
that they suspend, and now resume, but my SATA controller and NIC do not seem 
to wake up properly. Since my rootfs is on the SATA controller, things 
quickly hang thereafter.

Oh well.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

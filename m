Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVJKQDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVJKQDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVJKQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:03:47 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:4315 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751133AbVJKQDq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:03:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NvRb4JUkxU1R+8nRB7gwC0gtPbO9N5KpGVwRdotv1edCcKsAQr+TDLa0/4p/eL05fnjo4sWH5bz5nbJPP36kMzQQSUgDP/gXjYFu08VDAn5e0w54Gk0S05DCKl7xYCD02Wi64eivf7Dnpc/7JEhTHmf/amepidzwYjIRxe9SzQc=
Message-ID: <5bdc1c8b0510110903p250566dfs575768033029acff@mail.gmail.com>
Date: Tue, 11 Oct 2005 09:03:45 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc4-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051011111454.GA15504@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051011111454.GA15504@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> i have released the 2.6.14-rc4-rt1 tree, which can be downloaded from
> the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
> lots of fixes all across the spectrum. x64 support and debugging
> features on x64 should be in a much better shape now. Same for ARM.
>
>         Ingo

2.6.14-rc4-rt1 is up and running here. I'm starting without debug
disabled to look at whether I get xruns at all. It's been a while
since I've done that so I want to get a baseline. I'll do some latency
testing no matter what later this morning (a kernel recompile) to make
sure your fix for 64-bit processors is working.

I am seeing one strange thing in the 1394 area. dmesg didn't tell me
what device a newly mounted 1394 drive became. This makes it harder to
mount drives with partitions that cannot be labeled.

ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:05:08.0[A] -> Link [APC3] -> GSI 18 (level,
low) -> IRQ 66
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[66] 
MMIO=[da014000-da0147ff]  Max Packet=[4096]
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800286410000f43]
eth0: no IPv6 routers present
ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c504e0006463]
scsi4 : SCSI emulation for IEEE-1394 SBP-2 Devices
lightning ~ #

I believe it used to say after a mount that the partition became
/dev/sdb2, etc. This makes it harder to mount drives with partitions
that cannot be labeled. For mounted partitions I can find it in df:

lightning ~ # df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda3              9614148   7967288   1158484  88% /
udev                    255228       304    254924   1% /dev
shm                     255228         0    255228   0% /dev/shm
myth14:/video        225373664 142751296  71174080  67% /video
/dev/sdb2             48070504  42864832   2763792  94% /home/mark/Gigs
/dev/sdc1             57685532  47539424   7215856  87% /home/mark/music
lightning ~ #

Thanks. Everything else looks great so far.

Cheers,
Mark

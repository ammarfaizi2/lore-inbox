Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbVJ2L1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbVJ2L1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVJ2L1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 07:27:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:50824 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750994AbVJ2L1v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 07:27:51 -0400
Subject: Re: Intel D945GNT crashes with AGP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1130518160.5372.6.camel@blade>
References: <1130506715.5345.7.camel@blade>
	 <20051028162806.GA4340@redhat.com>  <1130518160.5372.6.camel@blade>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 13:27:47 +0200
Message-Id: <1130585267.5360.12.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> >  > The problematic part is the Intel AGP module (intel_agp), because if I
> >  > don't compile it the system works fine. There is an oops coming, but so
> >  > far I wasn't able to get it out. Does anyone have seen this problem
> >  > before and have some patches for me to try? Otherwise I need to try to
> >  > get this oops message.
> > 
> > You never mentioned what kernel you're running.
> > If it's a recent -mm, there's an AGP optimisation patch to do less
> > frequent TLB flushes, which may be worth backing out.
> > 
> > If you're running mainline, I'm puzzled.
> 
> basically I am running mainline, but I also tried your agpgart tree and
> both are having problems.

I also checked a non-SMP and non-preempt kernel. Both make my system
crash when killing the X server.

> > It'd be useful to see that oops.
> 
> I am working on it and actually it is enough to just kill the X process
> to crash the system. I saw parts of the oops and it seems that there are
> some RCU calls in the backtrace, but this might not help at all. So it
> seems that I really need that oops.

So getting the oops is really hard. I can't get it via serial port and
the netconsole (it uses an e100) is also not working. I tried to run
framebuffer, but I can only use vesafb and the resolution is nothing
better than any text console and I wasn't able to change it. So taking a
picture of the oops is also not an option. What other possible ways I
have to finally get the oops out of the system?

And btw why can't I compile the intelfb on x86_64? I use the internal
graphics card (8086:2772) of the D945GNT motherboard.

0000:00:02.0 VGA compatible controller: Intel Corporation 945G Integrated Graphics Controller (rev 02)

The Kconfig file makes it unselectable on x86_64 system.

config FB_INTEL
        tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
        depends on FB && EXPERIMENTAL && PCI && X86 && !X86_64

It seems that the most recent support in this driver is for the 915G and
not for the 945G. Are they so different that we need a complete new
driver or is the !X86_64 a relict from old times?

Regards

Marcel



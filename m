Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288756AbSAXRui>; Thu, 24 Jan 2002 12:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288763AbSAXRu2>; Thu, 24 Jan 2002 12:50:28 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:60801
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S288756AbSAXRuQ>; Thu, 24 Jan 2002 12:50:16 -0500
Date: Thu, 24 Jan 2002 09:49:37 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Rasmus =?iso-8859-1?Q?B=F8g?= Hansen <moffe@amagerkollegiet.dk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a chipset)
In-Reply-To: <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk>
In-Reply-To: <20020124155853Z287177-13996+11274@vger.kernel.org> <Pine.LNX.4.44.0201241803540.1345-100000@grignard.amagerkollegiet.dk>
Reply-To: whitney@math.berkeley.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Rasmus Bøg Hansen wrote:

> When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> again the last command run, follwing this from the kernel: 
>   Power down.  
>   hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5 
> And again my system hangs.

I have an ASUS A7V motherboard, similar to your ASUS A7V133.  I find
that stock kernel (2.4.18-pre7) APM powers off the machine, but stock
kernel ACPI does not.  However, the Intel ACPI patch, available from
http://developer.intel.com/technology/IAPC/acpi/downloads.htm against
kernel 2.4.16, does power down my machine.  I was able to forward port
this to 2.4.18-pre7 without too much trouble by starting with 2.4.16,
applying the Intel ACPI patch first, and then applying kernel
patch-2.4.17 and kernel patch-2.4.18-pre7.

As to the merits of the amd_disconnect patch that started this thread,
under 2.4.18-pre7-acpi, I get an idle CPU temperature of about 48 C.
With the amd_disconnect patch, it drops to 32-35 C, wow!  As
previously discussed, APM + amd_disconnect on an Athlon does not
provide any power savings, one needs ACPI + amd_disconnect.

Note that on this motherboard (and perhaps all ASUS Via chipset
motherboards, including the A7V133), one needs the following line in
/etc/sensors.conf to get reasonable lm_sensors CPU temperatures:
  compute temp2 @*2, @/2
This is as described at http://www2.lm-sensors.nu/~lm78/support.html
in Ticket 775.

Best wishes,
Wayne

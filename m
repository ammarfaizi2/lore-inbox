Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRCVW43>; Thu, 22 Mar 2001 17:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132229AbRCVW4U>; Thu, 22 Mar 2001 17:56:20 -0500
Received: from hypnos.cps.intel.com ([192.198.165.17]:37583 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S132226AbRCVW4P>; Thu, 22 Mar 2001 17:56:15 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE7A2@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Woller, Thomas'" <twoller@crystal.cirrus.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Incorrect mdelay() results on Power Managed Machines x86
Date: Thu, 22 Mar 2001 14:53:35 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> During resume the IBM thinkpad with the cs46xx driver needs 
> to delay 700
> milleseconds, so if the machine is booted up on battery power, then to
> ensure that the delay is long enough, then a value of 3000 
> milleseconds is
> must be programmed into the driver (3 seconds!).  all the 
> mdelay and udelay
> wait times are incorrect by the same factor, resulting in some serious
> problems when attempting to wait specific delay times in 
> other parts of the
> driver.  

Well yes this is a problem, but only when starting out with a low effective
CPU freq and going high - the reverse is usually OK because longer than
anticipated waits are OK.

However, you can alleviate this problem by not using udelay (or mdelay) but
using a kernel timer. I would think you should be doing this anyway (700ms
is a LONG TIME) but this should also work regardless of effective CPU freq.

A grep of the kernel source shows cs46xx isn't even doing the biggest
mdelay. I can understand the use of spinning on a calibrated loop for less
than a clock tick, but I gotta think there are better ways for longer
periods.

I wonder if there is a way to modify mdelay to use a kernel timer if
interval > 10msec? I am not familiar with this section of the kernel, but I
do know that Microsoft's similar function KeStallExecutionProcessor is not
recommended for more than 50 *micro*seconds.

Regards -- Andy


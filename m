Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268445AbTANAng>; Mon, 13 Jan 2003 19:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268456AbTANAng>; Mon, 13 Jan 2003 19:43:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:46556 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268445AbTANAne> convert rfc822-to-8bit; Mon, 13 Jan 2003 19:43:34 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Question about xAPIC lowest priority delivery
Date: Mon, 13 Jan 2003 16:50:34 -0800
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, John Stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301131650.34228.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

We've run into a hitch in the v2.5 Summit interrupt code.  When balance_irq() 
targets an I/O APIC interrupt to an idle CPU, the interrupt really goes to 
CPU 0 of the APIC cluster, no matter which one it was supposed to interrupt.  
These IRQs are in lowest priority mode, but only one bit is set (correctly) 
in the low nibble.  (The high nibble contains the APIC cluster number, the 
low nibble is a bitmap of CPUs in the cluster.)

When we change the delivery mode from lowest priority to fixed, IRQs go where 
they should.  However, this reintroduces some code from v2.4 that we were 
trying to simplify and remove.

Anyway, is this a known erratum for xAPICs in parallel mode?  (Namely, a bug 
in the XTPR arbitration logic in host bridges.)

Can anyone at Intel or otherwise enlighten me?

For that matter, does this happen on non-Summit xAPIC boxes?  Anyone out there 
with a >= 2 CPU P4 box that uses parallel interrupts care to comment?

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


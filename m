Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTKMWNq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 17:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbTKMWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 17:13:46 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:4589 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264444AbTKMWNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 17:13:45 -0500
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-kernel@vger.kernel.org>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>
Subject: Re: [PATCH] 2.4.23-rc1: cpu_sibling_map fix
Date: Thu, 13 Nov 2003 14:13:37 -0800
User-Agent: KMail/1.5
References: <7F740D512C7C1046AB53446D37200173618737@scsmsx402.sc.intel.com>
In-Reply-To: <7F740D512C7C1046AB53446D37200173618737@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311131413.37223.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 November 2003 11:32 am, Nakajima, Jun wrote:
> Can you please explain why the information by CPUID does not work for
> summit-based machine? The CPUID does not reflect the H/W configuration,
> and the BIOS needs to communicate via local APIC Ids instead?
>
> 	Jun

Easy.  Note this bit from Intel's IA-32 manual:

* Local APIC ID (high byte of EBX)--this number is the 8-bit ID that is
  assigned to the local APIC on the processor during power up.  This
  field was introduced in the Pentium 4 processor.

On almost all systems, the value latched in the CPU when it comes out of reset 
doesn't change over the life of the system.  However, our Summit boxes (and I 
suspect most NUMA boxen) have a BIOS that builds the full system out of 
smaller building blocks, each of which starts as an independent computer.  
The act of doing so means rewriting the local APIC ID register with a 
different value.  (It turns out that the CPU only latches 6 bits of APIC ID, 
but we need 8.)

Thus, we need the patch that reads the APIC ID register instead of just using 
the value from cpuid.  And we probably won't be the only ones either.

> > -----Original Message-----
[ Snip! ]


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

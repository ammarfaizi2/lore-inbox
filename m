Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbULJAmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbULJAmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbULJAmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:42:16 -0500
Received: from fmr19.intel.com ([134.134.136.18]:5033 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261686AbULJAmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:42:00 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Compatibilty patch] sigtimedwait
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 10 Dec 2004 08:40:57 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013C9FF@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Compatibilty patch] sigtimedwait
Thread-Index: AcTc6AVHUTkI5jMWS/iwIrGRDygN0QBaEBYw
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>, <ak@suse.de>, <ralf@linux-mips.org>,
       <paulus@au.ibm.com>, <schwidefsky@de.ibm.com>
X-OriginalArrivalTime: 10 Dec 2004 00:40:58.0406 (UTC) FILETIME=[EA5EFC60:01C4DE50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But I can't put a
#ifdef __LITTLE_ENDIAN 
here, 
Because 
only MIPS does the byte swapping in little endian mode.
X86_64 and ia64 does not.

> -----Original Message-----
> From: David S. Miller [mailto:davem@davemloft.net]
> Sent: Wednesday, December 08, 2004 1:35 PM
> To: Zou, Nanhai
> Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; Luck, Tony;
ak@suse.de;
> ralf@linux-mips.org; paulus@au.ibm.com; schwidefsky@de.ibm.com;
> Davem@davemloft.net
> Subject: Re: [Compatibilty patch] sigtimedwait
> 
> On Wed, 8 Dec 2004 08:48:56 +0800
> "Zou, Nanhai" <nanhai.zou@intel.com> wrote:
> 
> > This patch also merges all 6 32 bit layer sys_rt_sigtimedwait in
IA64,
> > X86_64, PPC64, Sparc64, S390 and MIPS into 1 compat_rt_sigtimedwait.
> >
> > I have only tested it on X86_64 and IA64.
> > It looks a bit weird for
> > #ifdef  __MIPSEL__ in generic code.
> > But I don't have any better idea for this.
> 
> The sparc64 part looks fine.
> 
> Instead of __MIPSEL__ you should be checking endianness
> with the generic __BIG_ENDIAN and __LITTLE_ENDIAN
> macros.

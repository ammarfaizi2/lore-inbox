Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUAVN74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 08:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAVN74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 08:59:56 -0500
Received: from aun.it.uu.se ([130.238.12.36]:23729 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264506AbUAVN7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 08:59:53 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16399.55109.244040.516731@alkaid.it.uu.se>
Date: Thu, 22 Jan 2004 14:59:33 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: "Georg C. F. Greve" <greve@gnu.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <20040122120854.GB3534@hell.org.pl>
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com>
	<m3u12pgfpr.fsf@reason.gnu-hamburg>
	<m3ptddgckg.fsf@reason.gnu-hamburg>
	<20040122120854.GB3534@hell.org.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Kozimor writes:
 > Thus wrote Georg C. F. Greve:
 > > So the problem we've been seeing seems to be related to the
 > > interaction between local APIC support and ACPI.
 > 
 > We've definitely had those problems before (with ASUS L3800C), there's 
 > even a patch fixing this issue (attached below) you might try.
 > I guess that's another of those lost and forgotten bugzilla bugs :)
 > 
 > -- 
 > Karol 'sziwan' Kozimor
 > sziwan@hell.org.pl
 > 
 > 
 > diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c patched/arch/i386/kernel/apic.c
 > --- linux-2.6.0-test8/arch/i386/kernel/apic.c	2003-10-18 05:43:36.000000000 +0800
 > +++ patched/arch/i386/kernel/apic.c	2003-10-30 23:17:50.000000000 +0800
 > @@ -836,8 +836,8 @@
 >  {
 >  	unsigned int lvtt1_value, tmp_value;
 >  
 > -	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
 > -			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 > +	lvtt1_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
 > +
 >  	apic_write_around(APIC_LVTT, lvtt1_value);

What is the purpose of this change?
I don't remember seeing this before on LKML. (I don't have time to read bugzilla.)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbTANVZb>; Tue, 14 Jan 2003 16:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTANVZb>; Tue, 14 Jan 2003 16:25:31 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:54269 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S264907AbTANVZb>;
	Tue, 14 Jan 2003 16:25:31 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15908.33367.652106.144165@napali.hpl.hp.com>
Date: Tue, 14 Jan 2003 13:34:15 -0800
To: "Howell, David P" <david.p.howell@intel.com>
Cc: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>,
       <linux-kernel@vger.kernel.org>
Subject: RE: timing an application
In-Reply-To: <331AD7BED1579543AD146F5A1A44D525127AD6@fmsmsx403.fm.intel.com>
References: <331AD7BED1579543AD146F5A1A44D525127AD6@fmsmsx403.fm.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 14 Jan 2003 12:37:05 -0800, "Howell, David P" <david.p.howell@intel.com> said:

  Dave> If this is on a IA32(Pentium II or later)/IA64 have you
  Dave> considered using the processor TSC register to get interval
  Dave> timestamps? It's a lot lighter weight and should give better
  Dave> resolution. When we have done this we compared the tick values
  Dave> directly.

  Dave> To convert TSC ticks to time the /proc/cpuinfo value for 'cpu
  Dave> MHz', see the glibc get_clockfreq.c and hp_timing.h
  Dave> implementation for details.

Note that it's tricky to uses TSC/ITC on multiprocessors, especially
on large machines, on which the clocks for different CPUs may drift, etc.
It's much better to use the clock_gettime() routine:

  http://www.opengroup.org/onlinepubs/007908799/xsh/clock_getres.html

Where properly implemented, this will be both as fast and accurate.

	--david

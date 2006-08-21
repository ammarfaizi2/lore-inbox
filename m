Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWHUPwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWHUPwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbWHUPwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:52:53 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:11486 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932072AbWHUPww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:52:52 -0400
Date: Mon, 21 Aug 2006 08:42:44 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: perfmon@napali.hpl.hp.com
Cc: oprofile-list@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: 2.6.17.9 new perfmon code base, libpfm, and pfmon packages
Message-ID: <20060821154244.GH28105@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have released another version of the perfmon new code base package.
This version of the kernel patch is relative to 2.6.17.9. This version
has taken more time than usual due some vacation and also massive rewriting
of the context switch code and various other changes in the generic kernel.

The kernel patch includes:
	- completely rewritten PMU context switch code (perfmon_ctxsw.c). The
	  new code takes advantage of the TIF mechanism in switch_to() for i386 and
	  x86_64. Given that support for TIF in switch_to() is not yet in
	  2.6.17.9, you need a prepatch that is included in the kernel package.
	  Now have only one kernel hook (pfm_ctxsw()) for context switch.

	- Fix P6 single enable bit (now more efficient to start/stop)

	- simplified the way we determine which thread is active for P4 with HT

	- renamed all AMD related code to amd64 (from x86_64 or amd)

	- lots of coding style cleanups

	- MIPS irq update by Phil Mucci

I have also released a new libpfm, libpfm-3.2-060821, which includes:

	- preliminary support for P4 32 and 64 bit mode by Kevin Corry from IBM

	- rewritten AMD event table to expose unit masks and allow masks to be
	  combined. Some event names have therefore changed!

	- new pfmsetup example to help automate kernel interface testing by
	  Kevin Corry from IBM

	- new showevtinfo example to list events and their description

	- remove useless pfm_print_event_info*() calls from library
	- added pfm_get_event_mask_code()
	- updated man pages for pfm_dispatch_events()
	- new man pages for all unit mask related interface calls
	- move all perfmon system calls number definitions to perfmon.h
	- made PFM_PLM* description more generic.
	- renamed all AMD file to amd64* from gen_x86_64*
	- added support for Pentium II (Chuck Ebbert)

This version of the library works with 2.6.17.1 and 2.6.17.9

Also a new version of pfmon, pfmon-3.2-060821, to take advantage of the
update in libpfm:

	- preliminary support for P4 32 and 64 bits by Kevin Corry from IBM.
	  Do not get too excited and it does not count anything just yet!

	- renamed all AMd related file/struct to amd64
	- all help message reformatted to 80 columns by Kevin Corry from IBM

	- added internal routine to show event info
	- added support to display event and unit masks names in results
	  
	- fix the detection of unavailable PMC registers. it was causing crashes
	  when used with sampling.

	- fix P6 edge/inv filter bug whereby 2nd event was not setup properly

You can get a more detailed log of changes the the CVS tree.

You can grab the new packages at our web site:

	 http://perfmon2.sf.net

Enjoy,

PS: I will post an kernel patch and a diffstat on the perfmon mailing list.
-- 

-Stephane

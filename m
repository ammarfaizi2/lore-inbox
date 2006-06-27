Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161236AbWF0R6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161236AbWF0R6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWF0R6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:58:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161236AbWF0R6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:58:00 -0400
Date: Tue, 27 Jun 2006 13:57:41 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Gerd Hoffmann <kraxel@suse.de>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] x86_64: x86_64 version of the smp alternative patch.
Message-ID: <20060627175741.GF1280@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gerd Hoffmann <kraxel@suse.de>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>
References: <200606261900.k5QJ0k9J028243@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261900.k5QJ0k9J028243@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 07:00:46PM +0000, Linux Kernel wrote:
 > commit d167a51877e94dda73dd656c51f363502309f713
 > tree eb02c2974b61777f575dfdc07d4c2adf83bde434
 > parent 240cd6a80642da528bfa382ec2ae4e3cb8991ea7
 > author Gerd Hoffmann <kraxel@suse.de> Mon, 26 Jun 2006 13:56:16 +0200
 > committer Linus Torvalds <torvalds@g5.osdl.org> Tue, 27 Jun 2006 00:48:14 -0700
 > 
 > [PATCH] x86_64: x86_64 version of the smp alternative patch.
 > 
 > Changes are largely identical to the i386 version:
 > 
 >  * alternative #define are moved to the new alternative.h file.
 >  * one new elf section with pointers to the lock prefixes which can be
 >    nop'ed out for non-smp.
 >  * two new elf sections simliar to the "classic" alternatives to
 >    replace SMP code with simpler UP code.
 >  * fixup headers to use alternative.h instead of defining their own
 >    LOCK / LOCK_PREFIX macros.
 > 
 > The patch reuses the i386 version of the alternatives code to avoid code
 > duplication.  The code in alternatives.c was shuffled around a bit to
 > reduce the number of #ifdefs needed.  It also got some tweaks needed for
 > x86_64 (vsyscall page handling) and new features (noreplacement option
 > which was x86_64 only up to now).  Debug printk's are changed from
 > compile-time to runtime.

This has one behaviour slightly different to the i386 version however.
If you boot an SMP machine it does this..

SMP: Allowing 4 CPUs, 2 hotplug CPUs
Initializing CPU#0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
..
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1

Seems wasteful (and noisy) to be doing this twice during boot.

		Dave

-- 
http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130397AbRAaHQZ>; Wed, 31 Jan 2001 02:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130948AbRAaHQQ>; Wed, 31 Jan 2001 02:16:16 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:44808 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130397AbRAaHQI>; Wed, 31 Jan 2001 02:16:08 -0500
Date: Wed, 31 Jan 2001 01:16:02 -0600
To: David Ford <david@linux.com>
Cc: Stephen Frost <sfrost@snowman.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
Message-ID: <20010131011602.F18746@cadcamlab.org>
In-Reply-To: <3A777E1A.8F124207@linux.com> <20010130220148.Y26953@ns> <3A77966E.444B1160@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A77966E.444B1160@linux.com>; from david@linux.com on Tue, Jan 30, 2001 at 08:37:02PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[David Ford]
> Mhm.  Is it worth the effort to make a dependancy on the CPU type for
> SMP?

Yes.  'make config' should not allow unsupported configurations, at
least where convenient.

So - are any of the other chip types also incompatible with SMP support
(the Winchips, maybe)?

Peter

--- 2.4.1/arch/i386/config.in~	Tue Jan 30 14:46:04 2001
+++ 2.4.1/arch/i386/config.in	Wed Jan 31 01:08:00 2001
@@ -154,7 +154,10 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
+# AMD SMP - not yet
+if [ "$CONFIG_MK6" != "y" -a "$CONFIG_MK7" != "y" ]; then
+   bool 'Symmetric multi-processing support' CONFIG_SMP
+fi
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'APIC and IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC
    if [ "$CONFIG_X86_UP_IOAPIC" = "y" ]; then
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

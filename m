Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275017AbTHGA3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275016AbTHGA3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:29:32 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:59554 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S272637AbTHGA2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:28:44 -0400
Date: Thu, 7 Aug 2003 01:27:25 +0100
From: Dave Jones <davej@redhat.com>
To: kwijibo@zianet.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check expection panic
Message-ID: <20030807002722.GA3579@suse.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>, kwijibo@zianet.com,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F3182B5.3040301@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3182B5.3040301@zianet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 04:35:33PM -0600, kwijibo@zianet.com wrote:
 > I decided to try out the new 2.6.0-test2 kernel today but
 > ran into a problem with booting it.  I narrowed it down to
 > the machine check expection code.  I get this panic from
 > the kernel on boot when I have it enabled
 > 
 > CPU0: Machine Check Exception: 0000000000000004
 > Bank0: f606200000000833 at 0000000000004040
 > Kernel Panic: CPU context corrupt.

Missing bugfix from the 2.4 kernel that never made it into 2.5.
Chances are you (and many other Athlon users) are hitting problems
because of this chunk..

Already pushed to Linus/Andrew.

		Dave


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1055  -> 1.1056 
#	arch/i386/kernel/cpu/mcheck/k7.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/06	davej@redhat.com	1.1056
# stupid off by one
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/cpu/mcheck/k7.c b/arch/i386/kernel/cpu/mcheck/k7.c
--- a/arch/i386/kernel/cpu/mcheck/k7.c	Wed Aug  6 23:33:40 2003
+++ b/arch/i386/kernel/cpu/mcheck/k7.c	Wed Aug  6 23:33:40 2003
@@ -81,7 +81,7 @@
 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	nr_mce_banks = l & 0xff;
 
-	for (i=0; i<nr_mce_banks; i++) {
+	for (i=1; i<nr_mce_banks; i++) {
 		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
 	}

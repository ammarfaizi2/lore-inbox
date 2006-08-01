Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWHAWVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWHAWVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHAWVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:21:55 -0400
Received: from ns1.suse.de ([195.135.220.2]:28869 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751240AbWHAWVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:21:55 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, sergio@sergiomb.no-ip.org
Subject: Re: [discuss] Re: [PATCH for 2.6.18] [2/8] x86_64: On Intel systems when CPU has C3 don't use TSC
Date: Wed, 2 Aug 2006 00:21:47 +0200
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
References: <44cbba2d.ejpOKfo7QfGElmoT%ak@suse.de> <200608012356.52893.ak@suse.de> <1154470000.5123.1.camel@localhost.portugal>
In-Reply-To: <1154470000.5123.1.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020021.47623.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 00:06, Sergio Monteiro Basto wrote:
> On Tue, 2006-08-01 at 23:56 +0200, Andi Kleen wrote:
> > Lost timer ticks print a rip. Do you have some samples?

Can you send dmesg with the following patch applied too?

cc'ing Suresh because he might have an explanation too then.

-Andi

Index: linux-2.6.18-rc3-work/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.18-rc3-work.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.18-rc3-work/arch/x86_64/kernel/smpboot.c
@@ -345,7 +345,7 @@ static void __cpuinit tsc_sync_wait(void
 	 * mess up a possible perfect synchronization with a
 	 * not-quite-perfect algorithm.
 	 */
-	if (notscsync || !cpu_has_tsc || !unsynchronized_tsc())
+	if (0 && (notscsync || !cpu_has_tsc || !unsynchronized_tsc()))
 		return;
 	sync_tsc(0);
 }

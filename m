Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTLDAqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTLDAqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:46:16 -0500
Received: from holomorphy.com ([199.26.172.102]:14031 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262782AbTLDAqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:46:15 -0500
Date: Wed, 3 Dec 2003 16:46:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HT apparently not detected properly on 2.4.23
Message-ID: <20031204004611.GX8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org
References: <3FCE2F8E.90104@stinkfoot.org> <20031203224023.GV8039@holomorphy.com> <3FCE74B0.9010506@stinkfoot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE74B0.9010506@stinkfoot.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 06:41:36PM -0500, Ethan Weinstein wrote:
> Ok, setting CONFIG_NR_CPUS=8 does indeed solve the HT issue, looks like 
> it was the numbering scheme:

Something like this might do the trick. NR_CPUS is already checked
indirectly via max_cpus.


-- wli


===== arch/i386/kernel/smpboot.c 1.17 vs edited =====
--- 1.17/arch/i386/kernel/smpboot.c	Mon Nov  3 05:48:33 2003
+++ edited/arch/i386/kernel/smpboot.c	Wed Dec  3 16:45:27 2003
@@ -1106,7 +1106,7 @@
 	 */
 	Dprintk("CPU present map: %lx\n", phys_cpu_present_map);
 
-	for (bit = 0; bit < NR_CPUS; bit++) {
+	for (bit = 0; bit < BITS_PER_LONG; bit++) {
 		apicid = cpu_present_to_apicid(bit);
 		
 		/* don't try to boot BAD_APICID */

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbTLHPaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTLHP37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:29:59 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:60570 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S265423AbTLHP34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:29:56 -0500
Date: Mon, 8 Dec 2003 08:29:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23+BK: PPC compile error
Message-ID: <20031208152954.GY912@stop.crashing.org>
References: <Pine.GSO.4.44.0312081201500.13502-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0312081201500.13502-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 12:02:44PM +0200, Meelis Roos wrote:

> gcc -D__ASSEMBLY__ -D__KERNEL__ -I/home/mroos/compile/linux-2.4/include -I/home/mroos/compile/linux-2.4/arch/ppc   -c -o cpu_setup_6xx.o cpu_setup_6xx.S
> cpu_setup_6xx.S: Assembler messages:
> cpu_setup_6xx.S:164: Error: Unrecognized opcode: `andi'

[ donning brown paper bag ]
Marcelo, please apply the following:

PPC32: Fix a thinko in arch/ppc/kernel/cpu_setup_6xx.S

--- 1.6/arch/ppc/kernel/cpu_setup_6xx.S	Wed Dec  3 08:48:47 2003
+++ edited/arch/ppc/kernel/cpu_setup_6xx.S	Mon Dec  8 08:26:37 2003
@@ -161,7 +161,7 @@
 	rlwinm	r3,r10,16,16,31
 	cmplwi	r3,0x000c
 	bne	1f			/* Not a 7400. */
-	andi	r3,r10,0x0f0f
+	andi.	r3,r10,0x0f0f
 	cmpwi	0,r3,0x0200
 	bgt	1f			/* Rev >= 2.1 */
 	li	r3,HID0_SGE		/* 7400 rev < 2.1, clear SGE. */

-- 
Tom Rini
http://gate.crashing.org/~trini/

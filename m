Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264760AbTFAW4F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 18:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264761AbTFAW4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 18:56:05 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:56508 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264760AbTFAW4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 18:56:01 -0400
Date: Mon, 2 Jun 2003 01:09:23 +0200 (MEST)
Message-Id: <200306012309.h51N9N8Y001441@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: brian@interlinx.bc.ca
Subject: Re: [PATCH][2.5] Honour dont_enable_local_apic flag
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Jun 2003 13:25:33 -0400, Brian J. Murrell wrote:
>So would you prefer something more along the lines of:
>
>--- arch/i386/kernel/setup.c.orig       2003-04-26 10:34:35.000000000 -0400
>+++ arch/i386/kernel/setup.c    2003-06-01 13:11:47.000000000 -0400
>@@ -845,6 +845,10 @@
>                 */
>                else if (!memcmp(from, "highmem=3D", 8))
>                        highmem_pages =3D memparse(from+8, &from) >> PAGE_S=
>HIFT;
>+               else if (!memcmp(from, "nolapic", 7)) {
>+                               clear_bit(X86_FEATURE_APIC, &boot_cpu_data.=
>x86_capability);
>+                               set_bit(X86_FEATURE_APIC, &disabled_x86_cap=
>s);
>+               }

Yes, but I meant using a __setup() or doing it in the no_apic case
in detect_init_APIC().

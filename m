Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270645AbTHACjX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 22:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270649AbTHACjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 22:39:23 -0400
Received: from mail.msi.umn.edu ([128.101.190.10]:59339 "EHLO mail.msi.umn.edu")
	by vger.kernel.org with ESMTP id S270645AbTHACjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 22:39:21 -0400
Date: Thu, 31 Jul 2003 21:39:21 -0500
From: Michael Bakos <bakhos@msi.umn.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
In-Reply-To: <20030731182705.5b4f2b33.akpm@osdl.org>
Message-ID: <Pine.SGI.4.33.0307312127190.23643-100000@ir12.msi.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that patch did fix the cpumask_t problem, however another one is present

  CC      arch/x86_64/kernel/mpparse.o
arch/x86_64/kernel/mpparse.c: In function `mp_parse_prt':
arch/x86_64/kernel/mpparse.c:899: error: too few arguments to function
`acpi_pci_link_get_irq'
make[1]: *** [arch/x86_64/kernel/mpparse.o] Error 1
make: *** [arch/x86_64/kernel] Error 2


While I was waiting for the cpumask_t fix, I tried to just comment out the
structure that caused the problem, it also got past the cpumask_t compile
error (however I didn't want to use a kernel with such a quick fix...).
When I did that I also stumbled on the mpparse problem and tried to fix
it. I don't know if it's a good fix but here's what I've done (I'd still
like some sort of patch since I'm not sure what are the exact effects):
I added stuff from the arch/i386/kernel/mpparse.c file
in void __init mp_parse_prt (void) in  arch/x86_64/kernel/mpparse.c
I added the variables:
int edge_level
int active_high_low

modified the acpi_pci_link_get_ifq call to add the 2 variables at the end
and I also changed the else part of that if to reflect the one in the i386
mpparse.c file.

Michael Bakhos


On Thu, 31 Jul 2003, Andrew Morton wrote:

> urgh, OK.  We're chasing around in circles here.  And the cpumask_t patch
> still isn't ready for merging.
>
>
> This might fix it.
>
<< patch sniped out>>


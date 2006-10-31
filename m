Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423075AbWJaKSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423075AbWJaKSS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423080AbWJaKSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:18:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423075AbWJaKSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:18:17 -0500
Date: Tue, 31 Oct 2006 02:18:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Giacomo Catenazzi <cate@cateee.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Panic with 2.6.19-rc3-ga7aacdf9: Invalid opcode at
 acpi_os_read_pci_configuration
Message-Id: <20061031021810.dd48361f.akpm@osdl.org>
In-Reply-To: <45470810.4040905@cateee.net>
References: <45470810.4040905@cateee.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 09:23:44 +0100
Giacomo Catenazzi <cate@cateee.net> wrote:

> Since few days I have this bug (not sure if it
> caused by changed configuration or if it is a regretion).
> The fololowing trace is from last git.
> 
> ...
>
> 
> [    0.012497] Brought up 4 CPUs
> [    0.174941] migration_cost=19,713
> [    0.215588] NET: Registered protocol family 16
> [    0.268807] ACPI: bus type pci registered
> [    0.316660] PCI: Fatal: No config space access function found

That looks pretty bad.

> [    0.385262] Setting up standard PCI resources
> [    0.452566] ACPI: Access to PCI configuration space unavailable
> [    0.527856] ACPI: Interpreter enabled
> [    0.571564] ACPI: Using IOAPIC for interrupt routing
> [    0.631370] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [    0.690684] ------------[ cut here ]------------
> [    0.745825] kernel BUG at drivers/acpi/osl.c:461!

And acpi keeled over as a result.

Do you have CONFIG_PCI_MULTITHREAD_PROBE=y?   If so, try disabling it.


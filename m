Return-Path: <linux-kernel-owner+w=401wt.eu-S965021AbXABXQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbXABXQ6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbXABXQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:16:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42104 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965021AbXABXQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:16:57 -0500
Date: Tue, 2 Jan 2007 23:27:06 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070102232706.49340349@localhost.localdomain>
In-Reply-To: <459AE459.8030107@pobox.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
	<20070102115834.1e7644b2@localhost.localdomain>
	<459AC808.1030807@pobox.com>
	<20070102212701.4b4535cf@localhost.localdomain>
	<459ACE9C.7020107@pobox.com>
	<20070102224559.2089d28d@localhost.localdomain>
	<459AE459.8030107@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.0 - 2.6.19:  libata guarantees that all PCI BARs are reserved to the 
> libata driver.

Please read the code Jeff. The old IDE quirk code in the PCI layer blanked
BAR 0 to BAR 3 of a compatibility mode controller

You then request_region 0x1f0 and 0x170 (BAR 0 and BAR 2) directly. You
never request the legacy BAR 1 and BAR 3 because they were erased by the
PCI quirk code and thus never claim the other port. Thats been a bug since
day one but it never seemed worth fixing in the short term.

Alan

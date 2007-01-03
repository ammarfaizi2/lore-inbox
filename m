Return-Path: <linux-kernel-owner+w=401wt.eu-S1751083AbXACA3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbXACA3j (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbXACA3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:29:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48424 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751083AbXACA3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:29:38 -0500
Date: Wed, 3 Jan 2007 00:39:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070103003948.2d3a77ac@localhost.localdomain>
In-Reply-To: <459AF0B4.10509@pobox.com>
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
	<20070102232706.49340349@localhost.localdomain>
	<459AF0B4.10509@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thus, if you avoid calling pci_request_regions (as your patch does), you 
> must manually provide the same guarantees that pci_request_regions 
> provides to its callers.

pci_request_regions reserves only BAR4/BAR5 in legacy mode because of the
fact the resources are mashed and eventually cleaare by the existing (pre
2.6.20-rc) PCI code. The new code does provide that guarantee which is
(unfortunately) precisely why you get the problem - because the combined
mode hack currently relies on it failing to do so.

Alan

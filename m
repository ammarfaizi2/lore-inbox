Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUC3RnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbUC3Rmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:42:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25032 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263781AbUC3Rm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:42:26 -0500
Message-ID: <4069B16F.7020306@pobox.com>
Date: Tue, 30 Mar 2004 12:42:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Bevand <bevand_m@epita.fr>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40695FF6.3020401@epita.fr>
In-Reply-To: <40695FF6.3020401@epita.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Bevand wrote:
> I think I am reaching the physical limit of the PCI bus (theoretically it
> would be 133 MB/s or 133000 blocks/s). When setting the PCI latency 
> timer of
> the SiI3114 controller to 240 (was 64), I am able to reach 100000 blocks/s.

That's interesting.

I wonder if we should look at making pci_set_master()'s latency timer 
setting code be a bit smarter.

It (pcibios_set_master in arch/i386/pci/i386.c) current checks the 
latency timer value programmed by the BIOS.  If the BIOS did not 
initialize the value, then it is set to 64.  Otherwise, it is clamped to 
the maximum 255.

I wonder if your BIOS shouldn't increase that latency timer value...?

	Jeff




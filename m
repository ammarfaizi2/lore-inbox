Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUC1AJU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 19:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUC1AJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 19:09:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29109 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261990AbUC1AI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 19:08:59 -0500
Message-ID: <4066178C.5020605@pobox.com>
Date: Sat, 27 Mar 2004 19:08:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40660FEC.8080703@pobox.com> <406610EA.4010607@pobox.com> <200403280113.58555.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403280113.58555.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 28 of March 2004 00:40, Jeff Garzik wrote:
> 
>>Jeff Garzik wrote:
>>
>>>That's the main limitation on request size right now...  libata limits
>>>S/G table entries to 128[1], so a perfectly aligned, fully merged
>>
>>    ...
>>
>>[1] because even though the block layer properly splits on segment
>>boundaries, pci_map_sg() may violate those boundaries (James B and
>>others are working on fixing this).  So...  for right now the driver
>>must check the s/g entry boundaries after DMA mapping, and split them
>>(again) if necessary.  IDE does this in ide_build_dmatable().
> 
> 
> You are right but small clarification is needed: code in ide_build_dmatable()
> predates segment boundary support in block layer (IDE never relied on it).

Agreed...  I'm saying it's still needed.

When the iommu layer knows about the boundaries it should respect, that 
code can be removed from libata and drivers/ide, IMO...  But also 
double-check and make sure IDE driver supports the worst case, by 
limiting to 128 PRD entries, not 256.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUC0Xkr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUC0Xkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:40:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261926AbUC0Xkk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:40:40 -0500
Message-ID: <406610EA.4010607@pobox.com>
Date: Sat, 27 Mar 2004 18:40:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Stefan Smietanowski <stesmi@stesmi.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40660877.3090302@stesmi.com> <200403280032.22180.bzolnier@elka.pw.edu.pl> <40660FEC.8080703@pobox.com>
In-Reply-To: <40660FEC.8080703@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> That's the main limitation on request size right now...  libata limits 
> S/G table entries to 128[1], so a perfectly aligned, fully merged 

    ...

[1] because even though the block layer properly splits on segment 
boundaries, pci_map_sg() may violate those boundaries (James B and 
others are working on fixing this).  So...  for right now the driver 
must check the s/g entry boundaries after DMA mapping, and split them 
(again) if necessary.  IDE does this in ide_build_dmatable().



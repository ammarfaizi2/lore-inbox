Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUC0Xh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 18:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUC0Xh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 18:37:56 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:35714 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262089AbUC0Xhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 18:37:52 -0500
Message-ID: <40661049.1050004@yahoo.com.au>
Date: Sun, 28 Mar 2004 09:37:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com>
In-Reply-To: <4066021A.20308@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> The "lba48" feature in ATA allows for addressing of sectors > 137GB, and 
> also allows for transfers of up to 64K sector, instead of the 
> traditional 256 sectors in older ATA.
> 
> libata simply limited all transfers to a 200 sectors (just under the 256 
> sector limit).  This was mainly being careful, and making sure I had a 
> solution that worked everywhere.  I also wanted to see how the iommu S/G 
> stuff would shake out.
> 
> Things seem to be looking pretty good, so it's now time to turn on 
> lba48-sized transfers.  Most SATA disks will be lba48 anyway, even the 
> ones smaller than 137GB, for this and other reasons.
> 
> With this simple patch, the max request size goes from 128K to 32MB... 
> so you can imagine this will definitely help performance.  Throughput 
> goes up.  Interrupts go down.  Fun for the whole family.
> 

Hi Jeff,
I think 32MB is too much. You incur latency and lose
scheduling grainularity. I bet returns start diminishing
pretty quickly after 1MB or so.

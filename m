Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264670AbUEUXCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264670AbUEUXCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265017AbUEUWuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:50:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36774 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265097AbUEUWtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:49:16 -0400
Message-ID: <40ADF0AC.1090404@tmr.com>
Date: Fri, 21 May 2004 08:06:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Brad Campbell <brad@wasp.net.au>, linux-kernel@vger.kernel.org
Subject: Re: libata 2.6.5->2.6.6 regression -part II
References: <40A8E9A8.3080100@wasp.net.au> <200405181513.12920.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405181513.12920.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Monday 17 of May 2004 18:34, Brad Campbell wrote:
> 
>>G'day all,
>>I caught the suggestion on my last post in the archives, but because I'm
>>not subscribed and wasn't cc'd I can't keep it threaded.
>>
>>I tried backing out the suggested acpi patch (No difference at all), and I
>>managed to get apic to work but it still hangs solid in the same place.
>>
>>dmesg attached.
>>
>>I managed to figure out that the VIA ATA driver captures my sata drives on
>>the via ports, explaining why sata_via misses them, but writing data to
>>those drives (hde & hdg) causes dma timeouts and locks the machine. No
>>useful debug info produced. The machine becomes non-responsive, throws a
>>couple of dma timeouts to the console and then loses all interactivity
>>(keyboard, serial, network) forcing a reset push.
>>
>>Is there any way I can prevent the VIA ATA driver capturing this device?
>>Unfortunately my boot drive is on hda on the on-board VIA ATA interface so
>>I need it compiled in.
> 
> 
> Disable the fscking PCI IDE generic driver.
> [ You are not the first one tricked by it. ]
> 
> AFAIR support for VIA 8237 was added to it before sata_via.c was ready.
> [ but my memory is... ]

What would happen if the generic driver was initialized last? That would 
let other more specific drivers grab devices first. The model which 
comes to mind is a route table, smallest subnet (or in this case most 
specific) being used first. Or would that open a whole other nest of snakes?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

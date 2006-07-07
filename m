Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWGGSZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWGGSZJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 14:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWGGSZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 14:25:09 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:32708 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1750752AbWGGSZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 14:25:07 -0400
Message-ID: <44AEA6EF.1030108@nortel.com>
Date: Fri, 07 Jul 2006 12:24:47 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question on pci, ordering, smp, etc.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jul 2006 18:24:50.0760 (UTC) FILETIME=[A287BC80:01C6A1F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Suppose I have a chunk of memory that is visible on the PCI bus.  I 
ioremap_nocache() it into kernel space on multiple cpus.  This memory is 
not used by any hardware devices, only the various cpus.  No DMA is 
involved.

What are the rules for portably accessing this memory?  I assume that I 
need to use readb/readw/readl/writeb/writew/writel and the other mmio 
helpers, and can't access it directly?  Given that those all give 
little-endian access, is there any way to access without the 
byte-swapping on big-endian systems?

How can I portably ensure that a write from one cpu will be visible when 
another cpu does a read?  Do I need to read from the device on the 
original cpu, or is there a way to flush it far enough that the other 
cpus will get the updated data even if it hasn't made it all the way 
back to the device yet?

Thanks,

Chris

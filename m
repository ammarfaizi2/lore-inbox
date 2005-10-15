Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVJOVEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVJOVEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 17:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVJOVEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 17:04:24 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46279 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751213AbVJOVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 17:04:24 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43516E78.6040502@s5r6.in-berlin.de>
Date: Sat, 15 Oct 2005 23:02:48 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org>
In-Reply-To: <20051015202944.GA10463@plato.virtuousgeek.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.472) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Sat, Oct 15, 2005 at 09:39:06PM +0200, Stefan Richter wrote:
>>Somebody mentioned this Linux-on-Toshiba-Satellite page recently on 
>>linux1394-user: http://www.janerob.com/rob/ts5100/index.shtml
>>The patch available from there was briefly discussed in February:
>>http://marc.theaimsgroup.com/?l=linux1394-devel&t=110786507900006
> 
> Yes, it seems to help.  If I boot up and modprobe the driver with
> toshiba=1, everything looks fine (I have no firewire devices to test
> with).  If I modprobe it with toshiba=0, the system gets sluggish for a
> second then IRQ 11 is disabled.  I had to update the patch though,

What about the PCI_CACHE_LINE_SIZE read/write?

Jody McIntyre wrote on 2005-02-09:
| Can you try the fix without
| pci_write_config_word(dev,PCI_CACHE_LINE_SIZE,toshiba_pcls);
| or pci_read_config_word(dev,PCI_CACHE_LINE_SIZE,&toshiba_pcls);
| and report if it still works?
|
| If it doesn't work, try leaving those lines out but adding
| pci_clear_mwi(dev);
| after the mdelay(), on the off chance that the device thinks mwi is on.
|
| The correct fix for this, if possible, is actually a pci quirk instead
| of the dmi-based approach, but if reading PCI_CACHE_LINE_SIZE before
| pci_enable_device() really is necessary, this will be rather difficult.
[ http://marc.theaimsgroup.com/?l=linux1394-devel&m=110797909807519 ]
-- 
Stefan Richter
-=====-=-=-= =-=- -====
http://arcgraph.de/sr/

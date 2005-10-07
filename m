Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbVJGQSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbVJGQSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbVJGQSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:18:25 -0400
Received: from zipcon.net ([209.221.136.5]:49624 "HELO zipcon.net")
	by vger.kernel.org with SMTP id S1030483AbVJGQSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:18:23 -0400
Message-ID: <43469FB8.50303@beezmo.com>
Date: Fri, 07 Oct 2005 09:18:00 -0700
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFClue] pci_get_device, new driver model
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CRAP, I think this one got sent when half written - sorry about that.

I'm missing something fundamental, and beg your indulgence.  Read LDD 3,
googled, and looked around in the code (but not in the right places...)

My current 2.6 drivers support multiple identical PCI boards per host.
The init code spins on pci_find_device and assigns instance/minor
numbers as boards are found.  Load script insmods the driver,
gets the major # from /proc/devices, and creates the /dev/ entries
on the fly.

If I convert to pci_get_device, it looks like subsequent calls in the
loop "put" the previously "gotten" device.  I need the pci_dev struct
to persist for later use (DMA, etc).  Do I take an additional bump to
the ref count for each board found before looping, and "put" each when
the driver is unloaded?

If I just give in to the new driver model how/when do I associate
instance/minor numbers with boards found?  Is it ever possible for
ordinary PCI boards to be (logically) removed and re-added w/out
removing the driver?  If so, how to maintain association between
a particular board and minor number?

I don't have any control over the tools available on the user's
target host.

Pointers to code supporting multiple boards per driver would be
very helpful.

Not subscribed but lurking.  Thanks,
Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch



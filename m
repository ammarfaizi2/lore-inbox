Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUIPEu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUIPEu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267469AbUIPEu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:50:26 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:7134 "EHLO
	merkurneu.hrz.uni-giessen.de") by vger.kernel.org with ESMTP
	id S267482AbUIPEta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 00:49:30 -0400
Date: Thu, 16 Sep 2004 14:48:58 +1000 (EST)
From: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
X-X-Sender: gc1007@magvis2.maths.usyd.edu.au
To: linux-kernel@vger.kernel.org
Subject: lost memory on a 4GB amd64
Message-Id: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au>
Organization: University of Giessen * Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

A friend of mine has a new Opteron based machine (Tyan Tiger K8W with two 
Opteron 24?) and 4GB main memory.

the problem is that about 512 MB of that memory is lost (AGP aperture and 
stuff). Although everything is perfect otherwise.
As far as I understand, all the PCI/AGP hardware uses the top end of the 
4GB address range to access their memory and there is just an 
"overlapping" of the addresses. thus only the remaining 3.5 GB are 
available.


Now there is an option in the BIOS called "Adjust Memory" which puts a 
certain amount of memory (several choices between 64MB and 2GB) above the 
4GB address range. I tried the 2GB setting which results in 2GB main 
memory at addresses 0-2GB and 2GB memory at addresses 4GB-6GB.

the problem is that the kernel (2.6.3-9mdksmp and vanilla 2.6.8.1) crashes
if this option is enabled as soon as some memory expensive program is run
(e.g. X)

I've seen some postings on the net talking about some "kernel patch" for
some "memory split", but nothing more specific. Do I just need a certain
patch to get it working or is there more to it?



BTW, the memory map displayed at boot is

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d3ff0000 (usable)
 BIOS-e820: 00000000d3ff0000 - 00000000d3fff000 (ACPI data)
 BIOS-e820: 00000000d3fff000 - 00000000d4000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)

if I leave the 4GB memory in one chunk and 

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000180000000 (usable)

if I enable the "adjust memory" option and split the memory in two 2GB 
blocks. 

Thanks in advance,

        Sergei
-- 
--------------------------------------------------------------------  -?)
         eMail:       Sergei.Haller@math.uni-giessen.de               /\\
-------------------------------------------------------------------- _\_V
Be careful of reading health books, you might die of a misprint.
                -- Mark Twain

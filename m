Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTKCVv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTKCVv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:51:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:50649 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263400AbTKCVvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:51:55 -0500
Date: Mon, 3 Nov 2003 13:51:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Charles Martin <martinc@ucar.edu>
cc: linux-kernel@vger.kernel.org
Subject: RE: interrupts across  PCI bridge(s) not handled
In-Reply-To: <000001c3a249$2f9f30a0$c3507580@atdsputnik>
Message-ID: <Pine.LNX.4.44.0311031344180.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Charles Martin wrote:
> 
> I do notice that bus #6, which is the backplane extender,
> has an APIC id of 0, but an APIC #0 was not enumerated. All other
> buses get assigned to the identified APICs of 8, 9 and 10. 

Yes. However, I have this suspicion that that is just more confusion by 
the BIOS tables. 

The reason APIC #0 wasn't enumerated is that it doesn't seem to exist in 
the MP tables. So not only does the PIRQ table not contain any information 
about that bus, but the MP tables are very silent about it too.

I dunno.. Maybe I'm reading this wrong, but it really looks like your BIOS 
tables are just pretty broken. 

It would really be interesting to hear whether using ACPI enumeration 
fixes it or at least whether the symptoms are different. Especially with 
newer hardware, the BIOS people have only ever tested their tables with 
Windows, and ACPI will have overridden any MPtable information, so..

		Linus


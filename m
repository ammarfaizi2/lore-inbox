Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTLMCWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 21:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLMCWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 21:22:22 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:38409 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S263267AbTLMCWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 21:22:18 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: lkml@sigkill.net
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups patch, no difference)   
Date: Sat, 13 Dec 2003 12:25:34 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312131225.34937.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and the modules list: 
 Module Size Used by Tainted: P 
 i2c-dev 4548 0 (unused) 
 i2c-core 13604 0 [i2c-dev]
<snip>


I am not certain your problems are nforce2 type specific.
Standard response: I don't suppose you can try a different stick of ram?

The reason I say that is that oops were very uncommon on either the 
epox 8rga+ or albatron km18G-pro MOBOS upon which I developed my
patches. Hard lockups were pretty much all I experienced prior to the 
patches except for an occasional X fail. Base OS flavour I
use is Suse 8.2 including gcc version (web updates utilised)

The udma patches are really just a cleanup on the address setup timing so
I do not think that they are a factor. 

The local apic ack delay timing patch needs athlon cpu and amd/nvidia ide on in 
kern config to kick in. If you are using it then I highly recommend uniprocessor 
ioapic config as well to go with it to route the 8254 timer irq0 through pin 0 of 
ioapic as using the apic config alone leaves a lot of ints generated on irq7 
which can cause problems. (Reason for 8259 making them spurious on irq7 
is explained in 8259A data sheet)

Also I now use a small patch to fixup proc info - only if you are using 
the 64 bit jiffies var hz patch, avail here:

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/0838.html

If you try acpi=off on boot and it is then not very stable then I think it has 
little to do with lockups patch as that is my fallback mode when I am 
playing with apic ioapic code. 

Another fallback I use at times is 

hdparm -Xudma3 /dev/hda

Hope this helps the confusion

Regards
Ross.

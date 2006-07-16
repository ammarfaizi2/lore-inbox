Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWGPJJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWGPJJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 05:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWGPJJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 05:09:58 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:42900 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751515AbWGPJJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 05:09:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=gKhtFNlA1J/IgPWvya1SdvMrkrTGNVqGsJ77mRNf+YOwQVnHb4kCzVTlBcV4nhFWieZBQ/iLy320rbt9zOAp4DlhOaSqsfvyKLcxN3ynVSNLDBNiKK+RQ99Vnm7RM8L01qfvpLRiRGSLbGF9NvT4S9wLsrRk7Hv+DWt8B1YFhIE=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc2][e1000][swsusp] - Regression - Suspend to disk and resume breaks e1000
Date: Sun, 16 Jul 2006 05:09:52 -0400
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607160509.52930.shawn.starr@rogers.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware

IBM ThinkPad T42
E1000 card info: 

02:01.0 Ethernet controller: Intel Corporation 82540EP Gigabit Ethernet 
Controller (Mobile) (rev 03)
        Subsystem: IBM PRO/1000 MT Mobile Connection
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 9
        Memory at c0220000 (32-bit, non-prefetchable) [size=128K]
        Memory at c0200000 (32-bit, non-prefetchable) [size=64K]
        I/O ports at 8000 [size=64]
        [virtual] Expansion ROM at ec000000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2

Steps to reproduce:

1) Suspend to disk normally
2) Resume from disk, the e1000 will show garbage for network statistics.

<snip>
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:83 errors:4294967254 dropped:4294967289 overruns:0 
frame:4294967268
          TX packets:76 errors:4294967282 dropped:0 overruns:0 
carrier:4294967275
          collisions:4294967289 txqueuelen:100
          RX bytes:50728 (49.5 KiB)  TX bytes:10138 (9.9 KiB)
          Base address:0x8000 Memory:c0220000-c0240000

Did something change in the driver that forgot to save the registers / not 
register back upon resumption from disk? I can't tell from the code how the 
driver knows its been brought down to S3 or S4 states.
 
A workaround is to then suspend to memory and resume, the e1000 will work 
again. This is repeatable each time.

Not sure if anyone else noticed this.

Thanks, 

Shawn.

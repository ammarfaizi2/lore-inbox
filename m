Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbTLKRzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbTLKRzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:55:32 -0500
Received: from scrye.com ([216.17.180.1]:57534 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S265211AbTLKRzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:55:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 11 Dec 2003 10:53:39 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: aacraid and large memory problem (2.6.0-test11)
In-Reply-To: <1070493945.25617.9.camel@markh1.pdx.osdl.net>
References: <20031202193520.74481F7CC8@voldemort.scrye.com>
	<1070396482.16903.11.camel@markh1.pdx.osdl.net>
	<20031203205141.EB67EF7C86@voldemort.scrye.com>
	<1070488662.21904.6.camel@markh1.pdx.osdl.net>
	<20031203222840.6A4E6F7C86@voldemort.scrye.com>
	<1070493945.25617.9.camel@markh1.pdx.osdl.net>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Message-Id: <20031211175342.1D94DF7C86@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:

Mark> On Wed, 2003-12-03 at 14:28, Kevin Fenzi wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> >>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:
>> 
Mark> I set up my machine to boot on the aacraid disk and it booted OK
Mark> for me.  Maybe its a problem with a particular model?
>>
Mark> lspci on mine says:
>>
Mark> 02:04.0 RAID bus controller: Digital Equipment Corporation
Mark> DECchip 21554 (rev 01) Subsystem: Adaptec Adaptec 5400S
>> This one says:
>> 
>> 05:01.0 RAID bus controller: Adaptec AAC-RAID (rev 01) Subsystem:
>> Adaptec AAC-RAID Flags: bus master, fast Back2Back, 66Mhz, slow
>> devsel, latency 64, IRQ 96 Memory at f8000000 (32-bit,
>> prefetchable) [size=64M] Expansion ROM at <unassigned> [disabled]
>> [size=64K] Capabilities: [80] Power Management version 2
>> 
>> It's a 2200S controller. bios version 6008
>> 
Mark> Could you try this patch?  I took the code from the adaptec
Mark> version of the driver.  It fiddles with the dma mask on the
Mark> 2200S controller among others.

Sorry it took me so long to try it. ;) 

Just applied to a 2.6.0-test11 kernel and rebooted and it worked!
Boot came up fine and it sees all 8GB of memory. 

free
             total       used       free     shared    buffers     cached
Mem:       8290996     712380    7578616          0      20956     569352
- -/+ buffers/cache:     122072    8168924
Swap:      8385920          0    8385920

Red Hat/Adaptec aacraid driver (1.1.2 Dec 10 2003)
AAC0: kernel 4.0.4 build 6008
AAC0: monitor 4.0.4 build 6008
AAC0: bios 4.0.0 build 6008
AAC0: serial b7e06ffafaf001
AAC0: 64 Bit PAE enabled
scsi0 : aacraid

This looks like a good patch here. 

Mark> Mark.

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE/2K8l3imCezTjY0ERAr0aAJkBLLGSLT5f4XygLR7uTwvQ6bQWSwCeIpUQ
GNFgepA9aOlk0MMUGDNHGmY=
=wOp5
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424248AbWLHDsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424248AbWLHDsZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 22:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424279AbWLHDsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 22:48:24 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:40303 "EHLO
	outbound2-cpk-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1424248AbWLHDsX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 22:48:23 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early
 usb debug port support.
Date: Thu, 7 Dec 2006 19:48:17 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64
 Early usb debug port support.
Thread-Index: AccYw/zOagCxxqbcSVaHCEN1woRl+ABtjq7g
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Greg KH" <gregkh@suse.de>, ebiederm@xmission.com
cc: "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
X-OriginalArrivalTime: 08 Dec 2006 03:48:18.0457 (UTC)
 FILETIME=[B2B0A890:01C71A7B]
X-WSS-ID: 69663F080T02377329-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: linuxbios-bounces@linuxbios.org
[mailto:linuxbios-bounces@linuxbios.org] On Behalf Of
ebiederm@xmission.com


>Ok due to popular demands here is the slightly fixed patch that works
>on both i386 and x86_64.  For the i386 version you must not have
>HIGHMEM64G enabled. 

>I just rolled it all into one patch as I'm to lazy to transmit all
>3 of them.


I got

Firmware type: LinuxBIOS
Linux version 2.6.19-smp-gc9976797-dirty (root@lbsrv) (gcc version
4.0.2) #196 6
Command line: earlyprintk=ttyS0,115200 apic=debug pci=noacpi,routeirq
snd-hda-i
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000001000 (reserved)
 BIOS-e820: 0000000000001000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000c0000 - 00000000000f0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 0000000100000000 - 0000000240000000 (usable)
dbgp_num: 0
Found EHCI debug port
bar: 10 offset: 098
bar: 10 offset: 098
dbgp pre-set_fixmap_nocache
PANIC: early exception rip ffffffff809c24b4 error 0 cr2 ffff810000203ff8

Call Trace:
 [<ffffffff809c24b4>] __set_fixmap+0x84/0x202
 [<ffffffff809c05bb>] early_dbgp_init+0x259/0x55c
 [<ffffffff8022d958>] __call_console_drivers+0x64/0x72
 [<ffffffff809b242b>] do_early_param+0x0/0x57
 [<ffffffff809c0a20>] setup_early_printk+0x162/0x17e
 [<ffffffff809b2459>] do_early_param+0x2e/0x57
 [<ffffffff8023d051>] parse_args+0x159/0x1f3
 [<ffffffff809b24c2>] parse_early_param+0x40/0x4c
 [<ffffffff809b88ca>] setup_arch+0x1c1/0x636
 [<ffffffff809b2534>] start_kernel+0x55/0x208
 [<ffffffff809b2173>] _sinittext+0x173/0x177

RIP __set_fixmap+0x84/0x202

With Greg's USB Debug, host and target can talk.
target with console=ttyUSB0,115200n8
host with cat /dev/ttyUSB0
But if use minicom in host, it will not show '\r', I guess the usb debug
cable eat return char. Greg, Can you add that back in usb_debug by
replacing '\n' with '\r', '\n'?

With Eric code in LinuxBIOS, it will report "No device found in debug
port"

YH





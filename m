Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWAGCcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWAGCcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 21:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbWAGCcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 21:32:11 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:31637 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030322AbWAGCcK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 21:32:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=chUZK0QpUlZKTTkdnwt+2qxheVsTEm16oEEwHRvg/JRdBzPWgUiVWoFiVTl/TwFKMUMjBnEGGfzxvstdAEttzNgR4YqfUPnMn/smqtgnE7K7LQPHy0dTi9hiHiqeSFySW7sKxem9yTk9uSp4hH4DxFiGTCJLLHptJk26mUPVhUo=
Message-ID: <86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
Date: Fri, 6 Jan 2006 18:32:09 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: ebiederm@xmission.com
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Cc: Andi Kleen <ak@muc.de>, Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some code clear 3 byte in mptable from 0x468

00000460: 41 01 09 12 03 00 0f 00 41 02 09 13 03 00 0f 00
00000470: 41 03 09 10 03 03 05 00 43 00 ff 00 03 01 05 00
00000480: 43 00 ff 01

00000460: 41 01 09 12 03 00 0f 00 00 00 00 13 03 00 0f 00
00000470: 41 03 09 10 03 03 05 00 43 00 ff 00 03 01 05 00
00000480: 43 00 ff 01

it is third irq entry for pcie slot....

//Slot  PCIE x4
        for(i=0;i<4;i++) {
                smp_write_intsrc(mc, mp_INT,
MP_IRQ_TRIGGER_LEVEL|MP_IRQ_POLARITY_LOW, bus_ck804b_4, (0x00<<2)|i,
apicid_ck804b, 0x10 + (1+i+4-sbdnb%4)%4);
        }


/*Local Ints:   Type    Polarity    Trigger     Bus ID   IRQ    APIC ID PIN#*/
        smp_write_intsrc(mc, mp_ExtINT,
MP_IRQ_TRIGGER_EDGE|MP_IRQ_POLARITY_HIGH, bus_isa, 0x0, MP_APIC_ALL,
0x0);
        smp_write_intsrc(mc, mp_NMI,
MP_IRQ_TRIGGER_EDGE|MP_IRQ_POLARITY_HIGH, bus_isa, 0x0, MP_APIC_ALL,
0x1);

the range already in e820 reserved area...

Bootdata ok (command line is apic=debug pci=routeirq
ramdisk_size=65536 root=/dev/ram0 rw console=tty0
console=ttyS0,115200n8 )
Linux version 2.6.15-gdb9edfd7 (root@yhlunb) (gcc version 4.0.2
20050901 (prerelease) (SUSE Linux)) #13 SMP Fri Jan 6 17:58:25 PST
2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000000e7c (reserved)
 BIOS-e820: 0000000000000e7c - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 00000000000f0400 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 0000000100000000 - 0000000240000000 (usable)

YH

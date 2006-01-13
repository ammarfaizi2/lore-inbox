Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161565AbWAMRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161565AbWAMRJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161566AbWAMRJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:09:51 -0500
Received: from fsmlabs.com ([168.103.115.128]:19433 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1161565AbWAMRJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:09:51 -0500
X-ASG-Debug-ID: 1137172184-5659-15-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Fri, 13 Jan 2006 09:14:47 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Miroslaw Mieszczak <mirek@mieszczak.com.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, "Seth, Rohit" <rohit.seth@intel.com>,
       ajk <a@oo.ms>
X-ASG-Orig-Subj: Re: [2.6] Problem with PDC20265 on system with I865 chipset and PIV
 HT
Subject: Re: [2.6] Problem with PDC20265 on system with I865 chipset and PIV
 HT
In-Reply-To: <20060113001618.66821fcb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0601130910420.1579@montezuma.fsmlabs.com>
References: <43C6DA9D.4060300@mieszczak.com.pl> <20060113001618.66821fcb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.7276
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          BODY: Custom Rule 7568M
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Andrew Morton wrote:

> This decode from eip onwards should be reliable
> 
> Code;  c0110471 No symbols available
> 00000000 <_EIP>:
> Code;  c0110471 No symbols available   <=====
>    0:   c7 05 b0 d0 ff ff 00      movl   $0x0,0xffffd0b0   <=====
> Code;  c0110478 No symbols available
>    7:   00 00 00 
> Code;  c011047b No symbols available
>    a:   f0 0f b3 15 38 d6 57      lock btr %edx,0xc057d638
> Code;  c0110482 No symbols available
>   11:   c0 
> Code;  c0110483 No symbols available
>   12:   c3                        ret    
> Code;  c0110484 No symbols available
>   13:   83                        .byte 0x83
> Code;  c0110485 No symbols available
>   14:   78                        .byte 0x78
> 
> 
> That's oopsing when trying to write to the APIC:
> 
> 	apic_write_around(APIC_EOI, 0);
> 
> <cc's x86 people>
> 
> Is there any sane way in which APIC accesses can fault, or does this
> indicate bad hardware?

Without pagetable corruption no they shouldn't fault, interestingly this 
looks like;

http://bugzilla.kernel.org/show_bug.cgi?id=5565

Albeit with a pdc20262. Miroslaw, are there any other similarities in 
hardware with that bugzilla entry?

Thanks,
	Zwane


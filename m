Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbTDXJil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbTDXJil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:38:41 -0400
Received: from ltgp.iram.es ([150.214.224.138]:59012 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262599AbTDXJig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:38:36 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 24 Apr 2003 10:53:36 +0200
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
Message-ID: <20030424085336.GB6405@iram.es>
References: <200304232305_MC3-1-35C1-C1D1@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304232305_MC3-1-35C1-C1D1@compuserve.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:02:02PM -0400, Chuck Ebbert wrote:
>  Sample output:
> 
> 
>  desc.c -- dump linux descriptor tables, version 0.50
> 
>  GDT at c0306280, 32 entries:
> 
> #00: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #01: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #02: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #03: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #04: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #05: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #06: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #07: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #08: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #09: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #10: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #11: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #12: base=00000000 limit=ffff flags=cf9b <G=1 P=1 S=1 DPL=0 Code>
> #13: base=00000000 limit=ffff flags=cf93 <G=1 P=1 S=1 DPL=0 Data>
> #14: base=00000000 limit=ffff flags=cffb <G=1 P=1 S=1 DPL=3 Code>
> #15: base=00000000 limit=ffff flags=cff3 <G=1 P=1 S=1 DPL=3 Data>
> #16: base=c0353800 limit=00eb flags=008b <G=0 P=1 S=0 DPL=0 Busy TSS>
> #17: base=c0307c70 limit=0027 flags=0082 <G=0 P=1 S=0 DPL=0 LDT>
> #18: base=00000000 limit=0000 flags=c09a <G=1 P=1 S=1 DPL=0 Code>
> #19: base=00000000 limit=0000 flags=809a <G=1 P=1 S=1 DPL=0 Code>
> #20: base=00000000 limit=0000 flags=8092 <G=1 P=1 S=1 DPL=0 Data>
> #21: base=00000000 limit=0000 flags=8092 <G=1 P=1 S=1 DPL=0 Data>
> #22: base=00000000 limit=0000 flags=8092 <G=1 P=1 S=1 DPL=0 Data>
> #23: base=00000000 limit=0000 flags=409a <G=0 P=1 S=1 DPL=0 Code>
> #24: base=00000000 limit=0000 flags=009a <G=0 P=1 S=1 DPL=0 Code>
> #25: base=00000000 limit=0000 flags=4092 <G=0 P=1 S=1 DPL=0 Data>
> #26: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #27: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #28: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #29: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #30: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #31: base=c0355600 limit=00eb flags=0089 <G=0 P=1 S=0 DPL=0 Available TSS>

Nice but the limit field is 20 bits (shifted left by 12 bits if G=1).

[snipped]

> 
> 	asm("sgdt %0" : "=m" (gdtr));
> 	base = gdtr.base, num = (gdtr.limit + 1) >> 3;
> 	printf(" GDT at %08x, %d entries:\n\n", base, num);
> 	for (i = 0; i < num; i++) {
> 		xkm(rkm, kmem, base + 8*i, &gdte, sizeof(gdte), "rkm gdte");
> 		a = gdte.a, b = gdte.b, t = (b & 0x1f00) >> 8;
> 		printf("#%02d: base=%08x limit=%04x"
  		                               ^^^               
s/%04x/%05x/

> 		       " flags=%04x <G=%d P=%d S=%d DPL=%d %s>\n", i,
> 		       (b & 0xff000000) | ((b & 0xff) << 16) | (a >> 16),
> 		       a & 0xffff, (b & 0x00ffff00) >> 8, TEST_BIT(b,23),
  		       ^^^^^^^^^^
s/a & 0xffff/(a & 0xffff) | (b & 0x0f0000)/

And I'd also mask b with 0xf0ff00 to avoid the 4 higher bits of the
limit in the middle of the flags field.

Other suggestions left as an exercise to the reader:

a) distinguish 16 bit code from 32 bit code (GDT entry #19 is 16 bit code),

b) distinguish read/write from read-only and execute/read from
execute-only (are there any read-only or execute-only segments in the GDT?)

c) distinguish 16 and 32 bit expand down data (changes the upper
limit of the valid addresses, but it's never used in the GDT, so like
the conformant code it's not that important)

d) extend this for x86-64 :-)

Nothing to say about the IDT dump, though.

	Gabriel

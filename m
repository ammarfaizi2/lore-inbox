Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTDXQVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTDXQVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:21:45 -0400
Received: from ltgp.iram.es ([150.214.224.138]:8581 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S263765AbTDXQVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:21:42 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 24 Apr 2003 18:25:54 +0200
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
Message-ID: <20030424162554.GB11897@iram.es>
References: <200304241004_MC3-1-35CA-8D5B@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304241004_MC3-1-35CA-8D5B@compuserve.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 09:59:58AM -0400, Chuck Ebbert wrote:
> Gabriel Paubert wrote:
> 
> 
> > > #31: base=c0355600 limit=00eb flags=0089 <G=0 P=1 S=0 DPL=0 Available TSS>
> >
> > Nice but the limit field is 20 bits (shifted left by 12 bits if G=1).
> 
> 
>   Huh.  The diagram I used was blank where the upper four limit bits belong
> so I assumed it was unused... and for some reason I was thinking you
> shifted
> left by 16 bits when G=1, so I never noticed the missing four bits. Thanks.


> 
> 
> 
> > Other suggestions left as an exercise to the reader:
> > 
> > a) distinguish 16 bit code from 32 bit code (GDT entry #19 is 16 bit code),
> 
> 
>  BIOS?

Indeed for APM at least. If D (default operand size, bit 22 of b) bit is set
then the code segment is 32 bit code, if clear it's 16 bit. 

The same bit is used for the upper limit of expand down data segments,
cleared for 64k, set for 4G.

>   I now have it dumping LDTs, and should probably do at least cs:eip and
> eflags
> for each task.

LDT or TSS ? 

>  
> 
> > d) extend this for x86-64 :-)
> 
> 
>   Itanium. 8)

Itanium is not interesting, it uses the same format as i386 for
this and only uses the LDT/GDT in ia32 emulation mode. Interrupts
are very different but I don't remember how they work right now.

But x86_64 uses the reserved bit of the segment descriptors 
to define extended GDT entries (and LDT too IIRC) with 64 bit
bases and/or 64 bit code segments (have to download it again).
These entries occupy 16 bytes. The IDT format is different
(as well as the TSS format).

	Gabriel

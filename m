Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752203AbVHGPqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbVHGPqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 11:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbVHGPqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 11:46:49 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30131 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1752203AbVHGPqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 11:46:48 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] 6700/6702PXH quirk
Date: Sun, 7 Aug 2005 18:46:29 +0300
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>, Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, akpm@osdl.org, torvalds@osdl.org
References: <1123259263.8917.9.camel@whizzy> <20050806085013.GA17747@parcelfarce.linux.theplanet.co.uk> <20050806155755.GA17136@havoc.gtf.org>
In-Reply-To: <20050806155755.GA17136@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508071846.29292.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 August 2005 18:57, Jeff Garzik wrote:
> On Sat, Aug 06, 2005 at 09:50:13AM +0100, Matthew Wilcox wrote:
> > On Fri, Aug 05, 2005 at 11:34:55PM -0400, Jeff Garzik wrote:
> > > FWIW, compilers generate AWFUL code for bitfields.  Bitfields are
> > > really tough to do optimally, whereas bit flags ["unsigned int flags &
> > > bitmask"] are the familiar ints and longs that the compiler is well
> > > tuned to optimize.
> > 
> > I'm sure the GCC developers would appreciate a good bug report with a
> > test-case that generates worse code.  If you don't want to mess with their
> > bug tracking system, just send me a test case and I'll add it for you.
> 
> Its an order-of-complexity issue.  No matter how hard you try,
> bitfields will -always- be tougher to optimize, than machine ints.
> 
> Bitfields are weirdly-sized, weirdly-aligned integers.  A simple look at
> the generated asm from gcc on ARM or MIPS demonstrates the explosion of
> code that can sometimes occur, versus a simple 'and' test of a machine
> int and a mask.  x86 is a tiny bit better, but still more expensive to
> do bitfields than machine ints.

But we are talking about one-bit field here:

+šššššššunsigned intššššno_msi:1; š šššš/* device may not use msi */

If _this_ isn't optimized nicely into ANDs, ORs, etc, then
bug report is in order and gcc should be fixed.
--
vda


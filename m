Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263566AbTH3NUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 09:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTH3NUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 09:20:34 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:46604 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S263566AbTH3NUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 09:20:33 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Date: Sat, 30 Aug 2003 13:44:56 +0100
User-Agent: KMail/1.5.3
References: <200308281548.44803.tomasz_czaus@go2.pl> <20030828151708.0b13dd82.rddunlap@osdl.org> <200308301149.19944.gothick@gothick.org.uk>
In-Reply-To: <200308301149.19944.gothick@gothick.org.uk>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308301344.56545.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 Aug 2003 11:49, Matt Gibson wrote:
> On Thursday 28 Aug 2003 23:17, Randy.Dunlap wrote:
> > Yes, the kernel has decided that your processor only has 1 Bank of
> > MCE register data to report.  I don't know how/why.  Sorry.
>
> Could it be something to do with this (in
> arch/i386/kernel/cpu/mcheck/k7.c)?
>
> 	if (l & (1<<8))	/* Control register present ? */
> 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
> 	nr_mce_banks = l & 0xff;
>
> 	for (i=1; i<nr_mce_banks; i++) {
>
> Check out the "for".  Or am I reading this wrong?

Having checked back, this was changed between test-2 and test-3.  The 
checking code in k7_machine_check() still loops from 0 rather than 1.  I 
think this may be leading to false reporting of problems, which may be why I 
and Tomasz are seeing these MCE messages on our Athlons.

Anyone who knows more about this stuff care to comment?  Is someone looking 
after MCE at the moment?  I couldn't find out much info on it.

Thanks,

Matt

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon

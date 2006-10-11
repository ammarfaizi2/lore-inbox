Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030420AbWJKOft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbWJKOft (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWJKOft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:35:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030420AbWJKOfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:35:48 -0400
Date: Wed, 11 Oct 2006 07:35:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <lenb@kernel.org>
cc: Pavel Machek <pavel@ucw.cz>,
       =?ISO-8859-1?Q?Fr=E9d=E9ric_Riss?= <frederic.riss@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 suspend regression on Intel Macs
In-Reply-To: <200610110235.02435.len.brown@intel.com>
Message-ID: <Pine.LNX.4.64.0610110732390.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop> <20061010195022.GA32134@elf.ucw.cz>
 <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org> <200610110235.02435.len.brown@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Oct 2006, Len Brown wrote:
> 
> It is troubling that Linux now gets to add the burden of MacOS bug compatibility to
> Windows bug compatibility.  I asked the apple folks and they
> said they didn't see anyplace in MacOS where SCI_EN is restored
> from the OS, so perhaps we are following a different path through
> their firmware...

We definitely are. MacOS uses EFI. Linux (if you want to use a standard 
Linux distro image) uses Boot Camp, aka BIOS emulation.

> I don't think the risk here isn't that setting SCI_EN is going to break something.
> The risk is that excluding it from ACPI_PM1_CONTROL_PRESERVED_BITS
> will allow other writes to this register to clear that bit from the OS,
> which is clearly counter to what the spec says to do.

Is there _ever_ any valid reason to clear it? I wouldn't object at all to 
a patch that just forces it..

That said, I could imagine some strange AML sequence that clears that bit 
in order to do something really nasty (and then sets it again at the end). 
There's no limit to what horrors can lurk in peoples BIOSes.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbTCTLqm>; Thu, 20 Mar 2003 06:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbTCTLqm>; Thu, 20 Mar 2003 06:46:42 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:2946 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261390AbTCTLql>; Thu, 20 Mar 2003 06:46:41 -0500
Date: Thu, 20 Mar 2003 11:55:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: David Brownell <david-b@pacbell.net>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI MWI cacheline size fix
Message-ID: <20030320115520.GB6995@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	David Brownell <david-b@pacbell.net>,
	Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030320135950.A2333@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320135950.A2333@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:59:50PM +0300, Ivan Kokshaysky wrote:
 > +
 > +	pci_cache_line_size = 32 >> 2;
 > +	if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
 > +		pci_cache_line_size = 64 >> 2;	/* K7 & K8 */
 > +	else if (c->x86 > 6)
 > +		pci_cache_line_size = 128 >> 2;	/* P4 */
 >  

I'd feel more comfortable with this with a c->x86_vendor == X86_VENDOR_INTEL
on the else if clause. The above code will silently break if for eg,
VIA, Transmeta or any other clone manufacturer make a model 7 or higher CPU.

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031636AbWLAATI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031636AbWLAATI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031642AbWLAATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:19:08 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:39441 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1031636AbWLAATE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:19:04 -0500
Date: Fri, 1 Dec 2006 01:19:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061201001901.GA11057@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <200611252159.59414.ak@suse.de> <20061126131532.GA41703@dspnet.fr.eu.org> <200611262028.04638.ak@suse.de> <20061127190301.GA75765@dspnet.fr.eu.org> <20061127190748.GA7015@bingen.suse.de> <20061127202406.GA90483@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127202406.GA90483@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 09:24:06PM +0100, Olivier Galibert wrote:
> On Mon, Nov 27, 2006 at 08:07:48PM +0100, Andi Kleen wrote:
> > Is that with just the code movement patch or your feature patch
> > added too? If the later can you test it with only code movement
> > (and compare against vanilla kernel). at least code movement
> > only should behave exactly the same as unpatched kernel.
> 
> You misread.  Unpatched kernel does not work.  That's why I gave the
> git reference of the kernel too.  Patched kernel does not work either,
> unsurprisingly (bios gives correct tables on that box).

Ok, I'm trying to debug it, and it's a pain.  It's a timing issue,
mmcfg write accesses are too slow for something.  The get_base_addr()
call is enough to slow things down too much, which explains why the
fundamentally simpler x86-64 code works without a hitch.

Finding out what it is too slow for, though, is an interesting
proposition.  It's not entirely obvious it is actually related to the
sata accesses.

  OG.



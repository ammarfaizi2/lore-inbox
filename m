Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVBARse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVBARse (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVBARse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:48:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36057 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262081AbVBARsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:48:05 -0500
Date: Tue, 1 Feb 2005 17:47:58 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Brian King <brking@us.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
References: <41ED27CD.7010207@us.ibm.com> <1106161249.3341.9.camel@localhost.localdomain> <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk> <41FFBDC9.2010206@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FFBDC9.2010206@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 11:35:05AM -0600, Brian King wrote:
> >If we've done a write to config space while the adapter was blocked,
> >shouldn't we replay those accesses at this point?
> 
> I did not think that was necessary.

We have to do *something*.  We can't just throw away writes.

I see a few options:

 - Log all pending writes to config space and replay the log when the
   device is unblocked.
 - Fail writes to config space while the device is blocked.
 - Write to the saved config space and then blat the saved config space
   back to the device upon unblocking.

Any other ideas?

BTW, you know things like XFree86 go completely around the kernel's PCI
accessors and poke at config space directly?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

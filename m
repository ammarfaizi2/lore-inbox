Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUIWRfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUIWRfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUIWReO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:34:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60099 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268186AbUIWRb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:31:56 -0400
Date: Thu, 23 Sep 2004 18:31:51 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Sort generic PCI fixups after specific ones
Message-ID: <20040923173151.GX16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922214304.GS16153@parcelfarce.linux.theplanet.co.uk> <20040923172038.GA8812@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923172038.GA8812@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 10:20:38AM -0700, Greg KH wrote:
> On Wed, Sep 22, 2004 at 10:43:04PM +0100, Matthew Wilcox wrote:
> > The recent change that allowed PCI fixups to be declared everywhere
> > broke IDE on PA-RISC by making the generic IDE fixup be applied before
> > the PA-RISC specific one.  This patch fixes that by sorting generic fixups
> > after the specific ones.  It also obeys the 80-column limit and reduces
> > the amount of grotty macro code.
> 
> It looks like you are doing 2 different things here with this new macro.
> Having it run last, and leting the user not type the PCI_ANY_ID macro
> twice.  How about if you want to do a final final type pass, you mark it
> as such, and not try to hide it in this manner.

Not really.  There's two types of fixup (well, four if you multiply by
the header vs later possibility).  There's the incredibly specific ("this
device from this manufacturer forgets to set something properly") and
the incredibly general ("if this is a cardbus / IDE device, then ...").
This patch simply distinguishes between the two.  Obviously the general
ones run after the specific ones -- there's specific devices that forget
to set their class code, for example.

> And do we really want to call it "final final"?  What if we determine
> that we need a "final final final" pass?  Can't you fix this with the
> link order like was previously done?  I'd really prefer to not add
> another level.

I don't want to call it "final final" at all.  Did you miss the message
where I explained the problem with this being link order dependent?

> Oh, and cc:ing the pci maintainer might be nice next time :)

I already apologised to you on IRC for that yesterday.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain

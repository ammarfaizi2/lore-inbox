Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVAMUan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVAMUan (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAMU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:28:58 -0500
Received: from colin2.muc.de ([193.149.48.15]:32013 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261664AbVAMUX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:23:59 -0500
Date: 13 Jan 2005 21:23:54 +0100
Date: Thu, 13 Jan 2005 21:23:54 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050113202354.GA67143@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de> <1105626399.4664.7.camel@localhost.localdomain> <20050113180347.GB17600@muc.de> <1105641991.4664.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105641991.4664.73.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 06:46:33PM +0000, Alan Cox wrote:
> On Iau, 2005-01-13 at 18:03, Andi Kleen wrote:
> > You are saying that X during its own private broken PCI scan
> > stops scanning when it sees an errno? 
> > 
> > That sounds incredibly broken if true. I'm not sure how much
> > effort the kernel should really take to work around such
> > user breakage. I suppose an ffffffff return would work. 
> 
> X needs to be able to find the device layout in order to build its PCI
> mappings. Cached data is probably quite sufficient for this.

I mean i would expect it to continue scanning other entries when it sees
an error on one.  Is that not true?

The devices we're talking about here that do BIST are SCSI controllers etc.
that are normally of no interest to X.

> 
> > > Then you need to switch to wait_event_timeout(). Its not terribly hard
> > > 8)
> > 
> > Just complicating something that should be very simple.
> 
> You are breaking an established user space API. Its not suprising this
> will break applications is it. 

Are you sure these devices even return something useful during BIST?

As Brian said the device he was working with would just not answer,
leading to a bus abort.  This would get ffffffff on a PC.
You could simulate this if you want, although I think a EBUSY or EIO
is better.

-Andi


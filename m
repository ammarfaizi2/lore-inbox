Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVBQQeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVBQQeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 11:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVBQQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 11:33:59 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:54538 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262304AbVBQQds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 11:33:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GCjEHTleho2QQnhi+0YGABPHrdBgrrSqgU8EHZkpa/XH2IGA6uq0jAMEGLwp7oiMKcEli23FPl7E8rOJl3sJW4pxAY954SWXQbzRekbkiR25CSl8wv0ntk2XOyOgWCYSGCNhhKazBKJzrdv7H5scHYI0V0k9DnaZrQ2eO/Ppi+I=
Message-ID: <9e473391050217083312685e44@mail.gmail.com>
Date: Thu, 17 Feb 2005 11:33:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1108601294.5426.1.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200502151557.06049.jbarnes@sgi.com>
	 <1108515817.13375.63.camel@gaston>
	 <200502161554.02110.jbarnes@sgi.com> <1108601294.5426.1.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 11:48:14 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2005-02-16 at 15:54 -0800, Jesse Barnes wrote:
> > On Tuesday, February 15, 2005 5:03 pm, Benjamin Herrenschmidt wrote:
> > > What about printing "No PCI ROM detected" ? I like having that info when
> > > getting user reports, but I agree that a less worrying message would
> > > be good.
> >
> > Ok, how about this then?  It changes the printks in both drivers to KERN_INFO
> > and describes the situation a bit more accurately.
> >
> > Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> >
> > Thanks,
> > Jesse
> >
> > P.S. Jon, I think the pci_map_rom code is buggy--if the option ROM signature
> > is missing or indicates that there's no ROM, the routine still returns a
> > valid pointer making the caller thing it succeeded.  If we fix that up we can
> > fix up the callers.
> 
> No, pci_map_rom shouldn't test the signature IMHO. While PCI ROMs should
> have the signature to be recognized as containing valid firmware images
> on x86 BIOSes an OF, it's just a convention on these platforms, and I
> would rather let people put whatever they want in those ROMs and still
> let them map it...
> 

pci_map_rom will return a pointer to any ROM it finds. It the
signature is invalid the size returned will be zero. Is this ok or do
we want it to do something different?

-- 
Jon Smirl
jonsmirl@gmail.com

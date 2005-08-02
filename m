Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVHBKca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVHBKca (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 06:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVHBKc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 06:32:29 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:53508 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261473AbVHBKc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 06:32:28 -0400
Date: Tue, 2 Aug 2005 12:32:26 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
To: Stelian Pop <stelian@popies.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Greg KH <greg@kroah.com>,
       Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <20050802103226.GA5501@roarinelk.homelinux.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> <42EC9410.8080107@roarinelk.homelinux.net> <Pine.LNX.4.58.0507311054320.29650@g5.osdl.org> <Pine.LNX.4.58.0507311125360.29650@g5.osdl.org> <1122846072.17880.43.camel@deep-space-9.dsnet> <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org> <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122976168.4656.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 11:49:28AM +0200, Stelian Pop wrote:
> Le lundi 01 ao??t 2005 ?? 16:37 +0200, Stelian Pop a ??crit :
> 
> > > Also, it looks like sonypi really is pretty nasty to probe for, so it's 
> > > not enough to just say "oh, it's a sony VAIO, let's reserve that region". 
> > > Otherwise I'd just suggest adding a "dmi_check_system()" table to 
> > > arch/i386/pci/i386.c, at the top of "pcibios_assign_resources()", and 
> > > then you could just allocate things based on DMI information.
> 
> > Since every Vaio laptop out there seems indeed to use only the first IO
> > port range in the list, we can de-nastyify the probe. And if we don't
> > even bother to check for Type1 vs. Type2 devices and we reserve both,
> > then it may be acceptable to do the above.
> > 
> > See the attached patch below which does just that. This has NOT been
> > tested (only compile-tested), and moreover it has a high breakage
> > probability in case some Vaios cannot live with the fixed ioport choice.
> > 
> > Note that this patch will conflict with the recent Eric's one (added in
> > CC:), he may want to rediff his Type3 changes in case this patch gets
> > in.
> 
> I had no feedback at all on the patch so I have no idea if this will go
> in or not, but since Eric's patch was accepted into -mm I rediffed the
> patch in order to ease the testing (in case someone is willing to test
> it).

Does not work on -rc4-mm1. The IO-ports pre-reserved message appears,
though. The 2 io-regions are still located under the "CardBus #03"
device. Re-Applying
"revert-gregkh-pci-pci-assign-unassigned-resources.patch" makes it
work again.

-- 
 Manuel Lauss

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319242AbSHNIxj>; Wed, 14 Aug 2002 04:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319243AbSHNIxj>; Wed, 14 Aug 2002 04:53:39 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:23541 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S319242AbSHNIxi>; Wed, 14 Aug 2002 04:53:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Peter Samuelson <peter@cadcamlab.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Date: Wed, 14 Aug 2002 12:56:27 +0200
User-Agent: KMail/1.4.2
Cc: Greg Banks <gnb@alphalink.com.au>, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
References: <20020814043558.GN761@cadcamlab.org> <Pine.LNX.4.44.0208132342560.32010-100000@chaos.physics.uiowa.edu> <20020814054945.GO761@cadcamlab.org>
In-Reply-To: <20020814054945.GO761@cadcamlab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208141256.27680.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 August 2002 07:49, Peter Samuelson wrote:
> [Kai Germaschewski]
> > It comes of the cost of testing for the architecture, since
> > e.g. s390 does not want to include most of drivers/*, but that means
> > we'd actually collect this knowledge at a centralized place.
>
> What we need is an easy way to check for any arch.  CONFIG_ARCH_S390
> is the right idea (though s390x sets it as well, not sure if that's
> good or bad). 

It's not logical, but it tends to help because it's what's meant most
of the time. I don't know a single place in the kernel where you want
to test for (CONFIG_ARCH_S390 && !CONFIG_ARCH_S390X).

Rather than making everything depend on CONFIG_ARCH_THIS && CONFIG_ARCH_THAT,
I'd prefer if every driver depended on its bus type. With the new driver
model, every driver has a clearly defined bus type and driver class,
so it would be logical to have that driver option exactly when these two
are enabled. Of course, that probably means a huge amount of work but it 
helps avoid problems when a new architecture is added or an existing one
gets a new bus.
E.g., s390 used to have no support for SCSI, but with the zfcp driver
we enable drivers/scsi/Config.in, so now we get a lot of questions about
drivers that won't work. Enclosing the drivers in "CONFIG_ARCH_s390" != "y"
does help us, but it would still be wrong to do that for a Sparc kernel
that supports some of the PCI cards but not the ISA ones.

	Arnd <><

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWGJI1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWGJI1w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 04:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWGJI1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 04:27:52 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:9154 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751361AbWGJI1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 04:27:51 -0400
Subject: Re: [PATCH 2/3] disallow modular binfmt_elf32
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060710060603.GA9440@osiris.boeblingen.de.ibm.com>
References: <20060708180554.GB7034@lst.de>
	 <20060710060603.GA9440@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 10 Jul 2006 10:27:58 +0200
Message-Id: <1152520078.5834.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 08:06 +0200, Heiko Carstens wrote:
> On Sat, Jul 08, 2006 at 08:05:54PM +0200, Christoph Hellwig wrote:
> > Currently most architectures either always build binfmt_elf32 in the
> > kernel image or make it a boolean option.  Only sparc64 and s390 allow
> > to build it modularly.  This patch turns the option into a boolean
> > aswell because elf requires various symbols that shouldn't be available
> > to modules.  The most urgent one is tasklist_lock whos export this patch
> > series kills, but there are others like force_sgi aswell.
> > [...] 
> > Index: linux-2.6/arch/s390/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/arch/s390/Kconfig	2006-07-06 14:21:17.000000000 +0200
> > +++ linux-2.6/arch/s390/Kconfig	2006-07-08 19:08:46.000000000 +0200
> > @@ -119,7 +119,7 @@
> >  	default y
> >  
> >  config BINFMT_ELF32
> > -	tristate "Kernel support for 31 bit ELF binaries"
> > +	bool "Kernel support for 31 bit ELF binaries"
> >  	depends on COMPAT
> >  	help
> 
> Martin and I discussed this already a few days ago. This config option
> should go away on s390, since everybody who wants CONFIG_COMPAT also wants
> CONFIG_BINFMT_ELF32. See patch below which applies on top of yours:

Yes, the removal of the BINFMT_ELF32 Kconfig option has been part of the
s390 Kconfig cleanup patch as well, it is supposed to go away.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317483AbSFDL7K>; Tue, 4 Jun 2002 07:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317484AbSFDL7J>; Tue, 4 Jun 2002 07:59:09 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:19145 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S317483AbSFDL7H>; Tue, 4 Jun 2002 07:59:07 -0400
Message-Id: <200206041159.g54Bx5W87996@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Announce: Kernel Build for 2.5, release 3.0 is available
Date: Tue, 4 Jun 2002 15:59:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
In-Reply-To: <11725.1023166408@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 June 2002 06:53, Keith Owens wrote:

> kbuild-2.5-common-2.5.20-2.

I still have a link order problem in -common-2.5.20-[12] that I noticed
after I eventually tried to run my kbuild-2.5 kernel. 

The initialization code in arch/i386/pci needs the pci_bus_type object
from drivers/pci/pci-driver.c to be registered. Both is called at 
subsys_initcall level, but in kbuild-2.5 the arch specific parts are
run first. The symtom is a 'BUG in device.h:75' from get_bus() early in
bootup.

The brute force workaround for this problem is to put 
link_subdir(drivers/pci) before link_subdir(arch/$ARCH) in the top level 
Makefile.in.

I could not find out from the kbuild-2.4 files how or why it works there, but 
I don't think relying on the link order here is a good idea anyway, so it 
would best be fixed in the pci code itself.

Arnd <><

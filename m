Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVIAOMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVIAOMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVIAOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:12:03 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:8128 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S965136AbVIAOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:12:00 -0400
In-Reply-To: <200509010247.07399.arnd@arndb.de>
References: <200509010247.07399.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E11258A-70AD-4285-962E-797F7A3D55E3@freescale.com>
Cc: <linuxppc64-dev@ozlabs.org>, "Paul Mackerras" <paulus@samba.org>,
       "Stephen Rothwell" <sfr@canb.auug.org.au>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH,RFC] Move Cell platform code to arch/powerpc
Date: Thu, 1 Sep 2005 09:11:38 -0500
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 31, 2005, at 7:47 PM, Arnd Bergmann wrote:

> Move all files from arch/ppc64/kernel/bpa_* to arch/powerpc/ 
> platforms/cell,
>
> I would like to see a patch like this go into 2.6.14, for multiple  
> reasons:
>
> - The marketing folks have changed the names and we are no longer  
> supposed
>   to refer to Cell as 'BPA' or 'Broadband Processor Architecture'.
>   The platform is officially known as 'Cell Broadband Engine  
> Architecture',
>   while the CPU is the 'Cell Broadband Engine'.
>
> - We are now moving all platforms into arch/powerpc/platforms and  
> someone
>   has to start so we get a template for the other architectures to  
> follow.
>
> - It would be a big mess for me to maintain my own patches on top  
> of file
>   names that are different from mainline during the 2.6.14 freeze.
>
> My impression is that Cell is a good target for moving first,  
> because I
> have to move it anyway and the number of users is extremely low, so it
> doesn't cause too much harm if we screw up. What thing that makes  
> moving
> Cell relatively easy is that it only supports 64 bit and only a single
> hardware configuration so far.
>
> I have tested this a bit on Cell and also done compile-only test  
> for the
> other platforms, but it doesn't really make any changes to the code  
> itself.
>
> Please comment on wether this is what everybody like the merge process
> be like.

I'm not 100% sure if this is the right time for introducing a  
platform into arch/powerpc.  My concern is around that fact that we  
have not tried to move any "code" from arch/ppc or arch/ppc64 into  
arch/powerpc and so havent figured out how we are going to do that  
will not breaking arch/ppc & arch/ppc64.  By introducing cell this  
way we create a dependency between ppc64 and powerpc that might  
constrain decisions we want to make.

> Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>
>
> --
>  arch/powerpc/platforms/cell/Makefile     |    1
>  arch/ppc64/kernel/Makefile               |    5
>  arch/powerpc/platforms/cell/pic.c        |  269 +++++++++++++++++++ 
> +++
>  arch/ppc64/kernel/bpa_iic.c              |  270  
> ----------------------
>  include/asm-powerpc/cell-pic.h           |   62 +++++
>  arch/ppc64/kernel/bpa_iic.h              |   62 -----
>  arch/powerpc/platforms/cell/iommu.c      |  377 +++++++++++++++++++ 
> ++++++++++++
>  arch/ppc64/kernel/bpa_iommu.c            |  377  
> -------------------------------
>  arch/powerpc/platforms/cell/iommu.h      |   65 +++++
>  arch/ppc64/kernel/bpa_iommu.h            |   65 -----
>  arch/powerpc/platforms/cell/nvram.c      |  118 +++++++++
>  arch/ppc64/kernel/bpa_nvram.c            |  118 ---------

Should pic, iommu, and nvram really be in arch/powerpc/sysdev/

Also, since your renaming things any chance there is a better name  
for iic? (just wondering since its way to similar to what some people  
use for I2C).

>  arch/powerpc/platforms/cell/setup.c      |  138 +++++++++++
>  arch/ppc64/kernel/bpa_setup.c            |  140 -----------
>  arch/powerpc/platforms/cell/spider-pic.c |  190 +++++++++++++++
>  arch/ppc64/kernel/spider-pic.c           |  191 ---------------
>  arch/ppc64/Kconfig                       |   10
>  arch/ppc64/kernel/cpu_setup_power4.S     |    2
>  arch/ppc64/kernel/cputable.c             |    6
>  arch/ppc64/kernel/irq.c                  |    2
>  arch/ppc64/kernel/pSeries_smp.c          |    4
>  arch/ppc64/kernel/setup.c                |    8
>  arch/ppc64/kernel/traps.c                |    4
>  include/asm-ppc64/nvram.h                |    2
>  include/asm-ppc64/processor.h            |    7
>  25 files changed, 1248 insertions(+), 1245 deletions(-)


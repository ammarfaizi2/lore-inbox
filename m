Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSFEAap>; Tue, 4 Jun 2002 20:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317518AbSFEAao>; Tue, 4 Jun 2002 20:30:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:48577 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317517AbSFEAam>; Tue, 4 Jun 2002 20:30:42 -0400
Date: Tue, 4 Jun 2002 17:30:30 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Dave Jones <davej@suse.de>, Nathan <wfilardo@fuse.net>,
        linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com, linux-scsi@vger.kernel.org
Subject: Re: 2.5.20-dj2 : "Duplicate initializer" in drivers/scsi/aic7xxx/aic7xxx_linux.c
Message-ID: <20020604173030.A18317@eng2.beaverton.ibm.com>
In-Reply-To: <3CFD25B7.2090108@fuse.net> <20020604225201.X4751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 10:52:01PM +0200, Dave Jones wrote:
> On Tue, Jun 04, 2002 at 04:40:23PM -0400, Nathan wrote:
>  > gcc -D__KERNEL__ -I/home/wes/src/kernel/linux-2.5.20/include -Wall 
>  > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
>  > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
>  > -malign-functions=4     -DKBUILD_BASENAME=aic7xxx_linux  -c -o 
>  > aic7xxx_linux.o aic7xxx_linux.c
>  > aic7xxx_linux.c:2829: unknown field `abort' specified in initializer
>  > aic7xxx_linux.c:2829: unknown field `reset' specified in initializer
>  > 
>  > Erhm, what's that mean? ^_^  And more importantly, how does one fix that?
> 
> It means the scsi driver has no error handling. Either a, add
> appropriate error handling routines, or b, enable the option in
> the scsi menu labelled "Use SCSI drivers with broken error handling [DANGEROUS]"
> 
> This is the fallout of a patch from Christoph Hellwig to make it more
> obvious which drivers are still in need of attention.  This patch is
> missing from Linus' tree, so things compile fine there. As there's been
> little to no progress at fixing these, I'll push the same patch to Linus
> in the next round, so things will break there too.
> 
>     Dave.

The aic driver already uses the new error handler, it just references the
removed fields when initializing them to NULL.

-- Patrick Mansfield

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316759AbSFDUwC>; Tue, 4 Jun 2002 16:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316764AbSFDUwB>; Tue, 4 Jun 2002 16:52:01 -0400
Received: from ns.suse.de ([213.95.15.193]:8967 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316759AbSFDUwB>;
	Tue, 4 Jun 2002 16:52:01 -0400
Date: Tue, 4 Jun 2002 22:52:01 +0200
From: Dave Jones <davej@suse.de>
To: Nathan <wfilardo@fuse.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20-dj2 : "Duplicate initializer" in drivers/scsi/aic7xxx/aic7xxx_linux.c
Message-ID: <20020604225201.X4751@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan <wfilardo@fuse.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3CFD25B7.2090108@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 04:40:23PM -0400, Nathan wrote:
 > gcc -D__KERNEL__ -I/home/wes/src/kernel/linux-2.5.20/include -Wall 
 > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
 > -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
 > -malign-functions=4     -DKBUILD_BASENAME=aic7xxx_linux  -c -o 
 > aic7xxx_linux.o aic7xxx_linux.c
 > aic7xxx_linux.c:2829: unknown field `abort' specified in initializer
 > aic7xxx_linux.c:2829: unknown field `reset' specified in initializer
 > 
 > Erhm, what's that mean? ^_^  And more importantly, how does one fix that?

It means the scsi driver has no error handling. Either a, add
appropriate error handling routines, or b, enable the option in
the scsi menu labelled "Use SCSI drivers with broken error handling [DANGEROUS]"

This is the fallout of a patch from Christoph Hellwig to make it more
obvious which drivers are still in need of attention.  This patch is
missing from Linus' tree, so things compile fine there. As there's been
little to no progress at fixing these, I'll push the same patch to Linus
in the next round, so things will break there too.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

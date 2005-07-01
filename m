Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263172AbVGADSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbVGADSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 23:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbVGADSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 23:18:14 -0400
Received: from [206.246.247.150] ([206.246.247.150]:25792 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263172AbVGADSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 23:18:07 -0400
Date: Thu, 30 Jun 2005 23:18:01 -0400
From: Ben Collins <bcollins@debian.org>
To: rbrito@ime.usp.br
Cc: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701031801.GA12915@phunnypharm.org>
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org> <20050701024432.GA18150@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701024432.GA18150@ime.usp.br>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of this is class_simple changes.

However, there is a huge set of changes to sbp2. One thing that sticks out
is the entire sbp2_check_sbp2_command() function being ripped out. There's
some changes related to TYPE_SDAD devices (where did this come from?).

Try reverting just the sbp2.[ch] changes from the 2.6.13-rc1 tree.

I'll see if I can figure out why our tree and kernel tree have gotten so
far out of whack and how such huge changes that don't seem to fix anything
(like the large changes to sbp2) have gotten into the kernel proper
without being tested. Most of the sbp2 changes seem to be a new feature
rather than fixing minor or even major bugs.

On Thu, Jun 30, 2005 at 11:44:33PM -0300, Rog?rio Brito wrote:
> On Jun 30 2005, Ben Collins wrote:
> > Also, have you tried using 2.6.13-rc1 using linux1394.org's subversion tree?
> 
> Here is what I get when I try to substitute 2.6.13-rc1 with linux1394
> trunk's tree:
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> (...)
>   CC [M]  drivers/block/loop.o
>   CC [M]  drivers/block/pktcdvd.o
>   CC [M]  drivers/block/cryptoloop.o
>   CC [M]  drivers/char/agp/intel-agp.o
>   CC [M]  drivers/ieee1394/ieee1394_core.o
> drivers/ieee1394/ieee1394_core.c: In function `hpsbpkt_thread':
> drivers/ieee1394/ieee1394_core.c:1048: error: too many arguments to function `refrigerator'
> drivers/ieee1394/ieee1394_core.c: In function `ieee1394_init':
> drivers/ieee1394/ieee1394_core.c:1127: warning: implicit declaration of function `class_simple_create'
> drivers/ieee1394/ieee1394_core.c:1127: warning: assignment makes pointer from integer without a cast
> drivers/ieee1394/ieee1394_core.c:1165: warning: implicit declaration of function `class_simple_destroy'
> make[3]: *** [drivers/ieee1394/ieee1394_core.o] Error 1
> make[2]: *** [drivers/ieee1394] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/usr/local/media/progs/linux/linux'
> make: *** [stamp-build] Error 2
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> Thanks, Rog?rio Brito.
> 
> -- 
> Rog?rio Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> Homepage of the algorithms package : http://algorithms.berlios.de
> Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274982AbTHMNYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274990AbTHMNYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:24:48 -0400
Received: from ip144-173-busy.ott.istop.com ([66.11.173.144]:19213 "EHLO
	worf.vpn") by vger.kernel.org with ESMTP id S274982AbTHMNYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:24:45 -0400
Date: Wed, 13 Aug 2003 09:24:39 -0400
From: Christian Mautner <linux@mautner.ca>
To: linux-kernel@vger.kernel.org
Cc: Norbert Preining <preining@logic.at>
Subject: Re: SOLUTION Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030813132439.GA24883@mautner.ca>
References: <1060436885.467.0.camel@teapot.felipe-alfaro.com> <3F34D0EA.8040006@rogers.com> <20030809104024.GA12316@gamma.logic.tuwien.ac.at> <20030809115656.GC27013@www.13thfloor.at> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <20030809130641.A8174@electric-eye.fr.zoreil.com> <20030809090718.GA10360@gamma.logic.tuwien.ac.at> <01a201c35e65$0536ef60$ee52a450@theoden> <3F34D0EA.8040006@rogers.com> <20030813061546.GB24994@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030813061546.GB24994@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:15:46AM +0200, Norbert Preining wrote:
> On Die, 12 Aug 2003, Christian Mautner wrote:
> > Hast du auch einen kompletten Kernel tarball versucht? Wahrscheinlich
> 
> The solution is:
> 	Get a COMPLETE linux-2.6.0-test3.tar.bz2
> and 
> 	DO NOT USE patch

I'm pretty sure the problem is related to the file 
usr/initramfs_data.S. This file is automatically created by the
usr/Makefile, but not deleted by mrproper or distclean (in -test1). 

See l-k thread "remove initramfs temp files" of Aug 8.

The patch to -test2 contained the file usr/initramfs_data.S, and the
patch process fails since it's trying to create it. I ended up
accidently with garbage in usr/initramfs_data.S, to the effect that
the symbol .init.ramfs was empty (could be told from System.map),
which in turn had the effect that in init/initramfs.c the function
unpack_to_rootfs() was called with a length of 0 (&__initramfs_end ==
&__initramfs_start), which in turn prevented this very initial root
file system which is needed to mount root.

A warning message in unpack_to_rootfs() if it is called with a length
of 0 would have been very helpful.

Having make distclean remove initramfs_data.S would be very good
practice as well.

chm.

-- 
christian mautner -- chm bei istop punkt com -- ottawa, canada

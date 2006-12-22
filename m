Return-Path: <linux-kernel-owner+w=401wt.eu-S1752733AbWLVVJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbWLVVJr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 16:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbWLVVJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 16:09:46 -0500
Received: from ppp85-141-207-24.pppoe.mtu-net.ru ([85.141.207.24]:35609 "EHLO
	gw.home.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752733AbWLVVJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 16:09:45 -0500
X-Greylist: delayed 2968 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 16:09:45 EST
From: Alex Tomas <alex@clusterfs.com>
To: linux-ext4@vger.kernel.org
Subject: [RFC] delayed allocation for ext4
Organization: CFS
CC: <linux-kernel@vger.kernel.org>, alex@clusterfs.com
Date: Fri, 22 Dec 2006 23:20:08 +0300
Message-ID: <m37iwjwumf.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day,

probably the previous set of patches (including mballoc/lg)
is too large. so, I reworked delayed allocation a bit so
that it can be used on top of regular balloc, though it
still can be used with extents-enabled files only.

this time series contains just 3 patches:

 - booked-page-flag.patch
   adds PG_booked bit to page->flags. it's used in delayed
   allocation to mark space is already reserved for page
   (including possible metadata)

 - ext4-block-reservation.patch
   this is scalable free space management. every time we
   delay allocation of some page, a space (including metadata)
   should be reserved

 - ext4-delayed-allocation.patch
   delayed allocation itself, enabled by "delalloc" mount option.
   extents support is also required. currently it works only
   with blocksize=pagesize.


all the patches can be used in ftp://ftp.clusterfs.com/pub/people/alex/2.6.20-rc1/

the series passed basic tests like dd/dbench/fsx.

any comments/questions are very welcome.

thanks, Alex

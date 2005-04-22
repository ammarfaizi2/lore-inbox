Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVDVPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVDVPQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVDVPOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:14:08 -0400
Received: from [80.71.243.242] ([80.71.243.242]:19586 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262054AbVDVPKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:10:15 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17001.5070.79877.986252@gargle.gargle.HOWL>
Date: Fri, 22 Apr 2005 19:10:06 +0400
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] fix race in __block_prepare_write (again)
Newsgroups: gmane.linux.kernel
In-Reply-To: <1114068704.12751.8.camel@imp.csi.cam.ac.uk>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	<Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
	<1114067401.11293.3.camel@imp.csi.cam.ac.uk>
	<1114068058.5182.22.camel@npiggin-nld.site>
	<1114068704.12751.8.camel@imp.csi.cam.ac.uk>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes:

[...]

 > 
 > mm/filemap.c::file_buffered_write():
 > 
 > - It calls fault_in_pages_readable() which is completely bogus if
 > @nr_segs > 1.  It needs to be replaced by a to be written
 > "fault_in_pages_readable_iovec()".

Which will be only marginally less bogus, because page(s) can be evicted
from the memory between fault_in_pages_readable*() and
__grab_cache_page() anyway.

[...]

 > Best regards,
 > 
 >         Anton

Nikita.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVDVPxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVDVPxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVDVPw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:52:59 -0400
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:24551 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262023AbVDVPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:50:23 -0400
Subject: Re: [patch] fix race in __block_prepare_write (again)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <17001.5070.79877.986252@gargle.gargle.HOWL>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
	 <1114067401.11293.3.camel@imp.csi.cam.ac.uk>
	 <1114068058.5182.22.camel@npiggin-nld.site>
	 <1114068704.12751.8.camel@imp.csi.cam.ac.uk>
	 <17001.5070.79877.986252@gargle.gargle.HOWL>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 22 Apr 2005 16:50:06 +0100
Message-Id: <1114185006.4092.4.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-22 at 19:10 +0400, Nikita Danilov wrote:
> Anton Altaparmakov writes:
>  > mm/filemap.c::file_buffered_write():
>  > 
>  > - It calls fault_in_pages_readable() which is completely bogus if
>  > @nr_segs > 1.  It needs to be replaced by a to be written
>  > "fault_in_pages_readable_iovec()".
> 
> Which will be only marginally less bogus, because page(s) can be evicted
> from the memory between fault_in_pages_readable*() and
> __grab_cache_page() anyway.

That is true.  But it does make the race condition smaller.

A better approach would be to lock the pages into memory via set page
reserved or something.  Of course they will need unmarking straight
after and we would need to be careful to not unmark pages that were
marked reserved to start with.

Comments?

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


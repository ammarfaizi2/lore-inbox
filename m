Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTDLFZa (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 01:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTDLFZa (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 01:25:30 -0400
Received: from [12.47.58.73] ([12.47.58.73]:37152 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263170AbTDLFZ3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 01:25:29 -0400
Date: Fri, 11 Apr 2003 22:37:18 -0700
From: Andrew Morton <akpm@digeo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] first try for swap prefetch
Message-Id: <20030411223718.4ba9c024.akpm@digeo.com>
In-Reply-To: <200304120705.26408.schlicht@uni-mannheim.de>
References: <200304101948.12423.schlicht@uni-mannheim.de>
	<200304111352.05774.schlicht@uni-mannheim.de>
	<20030411143932.6bd0b08a.akpm@digeo.com>
	<200304120705.26408.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2003 05:37:06.0868 (UTC) FILETIME=[8E0B1F40:01C300B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
> How can I get the file pointer for a buffered page with the information 
> available in the kswapd (minly the page struct)??

You can't, really.  There can be any number of file*'s pointing at an inode.

The pagefault handler will find it by find_vma(faulting_address)->vm_file. 
Other codepaths use syscalls, and the user passed the file* in.

You can call page_cache_readahead() with a NULL file*.  That'll mostly work
except for the odd filesytem like NFS which will oops.  But it's good enough
for testing and development.

Or you could cook up a local file struct along the lines of
fs/nfsd/vfs.c:nfsd_read(), but I would not like to lead a young person
that way ;)


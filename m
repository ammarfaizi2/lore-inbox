Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVCDJPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVCDJPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVCDJMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:12:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:62403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVCDJMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:12:19 -0500
Date: Fri, 4 Mar 2005 01:11:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiser@namesys.com,
       mc@cs.stanford.edu
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o
 sync/dirsync option?
Message-Id: <20050304011141.5ff037dc.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.44.0503040025380.9443-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0503032211570.7754-100000@elaine24.Stanford.EDU>
	<Pine.GSO.4.44.0503040025380.9443-100000@elaine24.Stanford.EDU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> wrote:
>
> On Thu, 3 Mar 2005, Junfeng Yang wrote:
> 
> >
> > Hi,
> >
> > FiSC (our file system checker) emits several warnings on ext2, jfs and
> > reiserfs, complaining that diretories or files are lost while FiSC
> > believes they should already be persistent on disk. (ext3 behaves
> > correctly.)
> 
> I forget to mention, we are mainly looking for crash-recovery bugs.  The
> warnings can trigger this way:
> 1. do several file system operations
> 2. "crash" the test machine
> 3. get the crashed disk image, run fsck to recover
> 4. mount the recovered disk image
>
> I'm able to reproduce the same warnings on ext2 using the following
> program:
> 
> main()
> {
>         system("sudo umount /dev/hda9");
>         system("/sbin/mke2fs /dev/hda9");
>         system("sudo mount -t ext2 /dev/hda9 /mnt/sbd1 -o sync,dirsync");
>         creat("/mnt/sbd1/0002", 0777);
>         mkdir("/mnt/sbd1/0003", 0777);
> 	// unplug your power cord here :)  then use e2fsck to recover
> }

That would be a bug.  Please send the e2fsck output.

> uname -a shows
> Linux notus 2.6.8-1-686 #1 Thu Nov 25 04:34:30 UTC 2004 i686 GNU/Linux

It would be much better to test vaguely contemporary kernels.

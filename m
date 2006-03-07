Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWCGPjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWCGPjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWCGPjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:39:13 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:3248 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1751221AbWCGPjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:39:12 -0500
Date: Tue, 7 Mar 2006 08:39:10 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Joseph D. Wagner" <technojoe@josephdwagner.info>
Cc: "'Andreas Dilger'" <adilger@clusterfs.com>,
       "'Xin Zhao'" <uszhaoxin@gmail.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Why ext3 uses different policies to allocate inodes for dirs and files?
Message-ID: <20060307153910.GC7301@parisc-linux.org>
References: <20060307083319.GH6393@schatzie.adilger.int> <001901c641fc$ae8120e0$0201a8c0@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901c641fc$ae8120e0$0201a8c0@joe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 09:34:53AM -0600, Joseph D. Wagner wrote:
> > I'm not sure what it is you are saying.  Directories may be renamed, but
> > the inodes are never moved.
> 
> If the "dir inode" were to be moved closer to the "parent dir inode", this would become quite an expensive "move" operation, as it would have to move all of the "dir inodes" of the "i386-redhat-linux" directory and all subdirectories away from the "parent dir inode" of "/usr/local/lib/" and closer to the "parent dir inode" of "/usr/lib/".

inodes are allocated once and never moved.  We're talking about initial
allocation.  So even though files have their inodes allocated near
their parent directory's inode, their inode is not moved when moved to
another directory.

The reason, as Andreas said, is that if we did allocate directory inodes
near their parent inode, we would end up just filling up from the start
of the drive and never spreading out.

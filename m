Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWCGId0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWCGId0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWCGIdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:33:25 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:44704 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1752025AbWCGIdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:33:25 -0500
Date: Tue, 7 Mar 2006 01:33:19 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: "Joseph D. Wagner" <technojoe@josephdwagner.info>
Cc: "'Xin Zhao'" <uszhaoxin@gmail.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Why ext3 uses different policies to allocate inodes for dirs and files?
Message-ID: <20060307083319.GH6393@schatzie.adilger.int>
Mail-Followup-To: "Joseph D. Wagner" <technojoe@josephdwagner.info>,
	'Xin Zhao' <uszhaoxin@gmail.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
References: <4ae3c140603061342r26ca2226s2e6e41792104c633@mail.gmail.com> <002601c641a7$6687d680$0201a8c0@joe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002601c641a7$6687d680$0201a8c0@joe>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 06, 2006  23:24 -0600, Joseph D. Wagner wrote:
> > The policy seems to distribute dir inodes uniformly on all block
> > groups. Why do we want to do this?  Isn't it better to create a dir
> > inode close to its parent dir inode?
> 
> Directories can, and frequently are, moved.  If you kept the dir inode
> close to its parent dir inode, you'd have to move dir inodes around
> every time you move directories.  Less is more.

I'm not sure what it is you are saying.  Directories may be renamed, but
the inodes are never moved.

The reason that directory inodes are spread across the disk is that this
allows later balancing of the file inodes that are created within each
directory.  If all of the parent directories are kept in the same group,
you would just end up having all inodes at the start of the filesystem
in use, with high fragmentation and no locality between directories and
the files created therein, and similar problems with inode blocks.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.


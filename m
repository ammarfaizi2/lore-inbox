Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWIOL45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWIOL45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIOL45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:56:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12929 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751282AbWIOL45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:56:57 -0400
Date: Fri, 15 Sep 2006 13:56:55 +0200
From: Jan Kara <jack@suse.cz>
To: Pavel Mironchik <tibor0@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: ext2/3 create large filesystem takes too much time; solutions
Message-ID: <20060915115655.GA21992@atrey.karlin.mff.cuni.cz>
References: <401f4f10609120407j6816372mfdfea392dcae9e00@mail.gmail.com> <401f4f10609140052g48a92406i248f0f2c4175540d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401f4f10609140052g48a92406i248f0f2c4175540d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Ext2/3 does erase of inode tables, when do creation of new systems.
> This is very very long operation when the target file system volume is more 
> than
> 2Tb. Other filesystem are not affected by such huge delay on creation of
> filesystem. My concern was to improve design of ext3 to decrease time
> consuption of creation large ext3 volumes on storage servers.
> In general to solve problem, we should defer job of cleaning nodes to
> kernel. In e2fsprogs there is LAZY_BG options but it  just avoids doing
> erase of inodes only.
> 
> I see several solutions for that problem:
> 1) Add special bitmaps into fs header (inode groups descriptors?).
> By looking at those bitmaps kernel could determine if inode is not cleaned, 
> and
> that inode will be propertly initialized.
> 2) Add special identifiers into inodes. If super block id != inode id
> -> inode is dirty
> and should be cleaned in kernel, where super block id is generated on
> creation stage.
  Hmm, I don't know but how often do you need to create so big
filesystems? My feeling is that one can usually afford to spend some
time with a creation of a filesystem (and it is better to spend it
during creation than to add complexity to the run-time code). Also
having inodes zeroed out is more robust when filesystem is corrupted or
some other nasty thing happens... Just my 2 cents :)

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTDYEVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTDYEVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:21:50 -0400
Received: from terminus.zytor.com ([63.209.29.3]:64191 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262934AbTDYEVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:21:50 -0400
Message-ID: <3EA8BAB0.4080003@zytor.com>
Date: Thu, 24 Apr 2003 21:33:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
References: <1051182797.2250.10.camel@laptop-linux> <Pine.GSO.4.21.0304241335210.19942-100000@vervain.sonytel.be> <b8a2le$p88$1@cesium.transmeta.com> <20030424222737.X26054@schatzie.adilger.int>
In-Reply-To: <20030424222737.X26054@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> This "supersync" already exists, and it is supported by all of the
> journaling filesystems for LVM snapshots.  This is the VFS method
> write_super_lockfs in the ext3/reiserfs/XFS/JFS super_operations.
> Not only does it sync the dirty data to disk, but it also forces
> the journal to be empty and marks the filesystem clean, so that it
> can be snapshotted and read-only mounted (basically equivalent to
> unmounting the filesystem).
> 
> Unfortunately, even though the filesystems themselves have supported
> this VFS method for a long time, the actual code that calls these
> methods (sync_super_lockfs() and unlockfs()) are still only available
> as a patch from LVM.  The LVM/reiserfs folks have talked about submitting
> it to Marcelo for a long time now, but apparently still haven't done so.
> 

I really think this should be made available.  Perhaps we should have a 
sync1() system call which takes a flag set.  Then we could have 
sync1(SYNC_FLUSH_JOURNALS);

	-hpa


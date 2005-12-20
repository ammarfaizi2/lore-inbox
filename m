Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVLTLgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVLTLgH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 06:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVLTLgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 06:36:07 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:58850 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750947AbVLTLgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 06:36:05 -0500
Message-ID: <43A7EC67.5030400@namesys.com>
Date: Tue, 20 Dec 2005 14:35:03 +0300
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: bug in get_name of export operations?
References: <43A6CA3A.5010905@namesys.com> <20051220025209.df6d5c81.akpm@osdl.org>
In-Reply-To: <20051220025209.df6d5c81.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Andrew Morton wrote:
> "Vladimir V. Saveliev" <vs@namesys.com> wrote:
>>Hello
>>
>>Please point my error if I am wrong:
>>
>>fs/exportfs/expfs.c:get_name() opens a directory with:
>>file = dentry_open(dget(dentry), NULL, O_RDONLY);
>>which results in file where file->f_vfsmnt == NULL.
>>
>>Then fs/readdir.c:vfs_readdir() and, therefore,
>>include/linux/fs.h:file_accessed(file) are called.
>>file_accessed() calls fs/inode.c:touch_atime() which tryies to dereference mnt
>>which is NULL.
>>
> 
> I think you're looking at the -mm tree, in which Christoph changed all that
> stuff.
> 

Ah, sorry, yes, I found that in 2.6.15-rc5-mm3


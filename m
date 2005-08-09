Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVHIAaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVHIAaf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVHIAaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:30:35 -0400
Received: from NS6.Sony.CO.JP ([137.153.0.32]:24200 "EHLO ns6.sony.co.jp")
	by vger.kernel.org with ESMTP id S932386AbVHIAae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:30:34 -0400
Message-ID: <42F7F998.7080400@sm.sony.co.jp>
Date: Tue, 09 Aug 2005 09:32:24 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT
References: <4zfoZ-5u4-9@gated-at.bofh.it> <E1E2GAN-0003Pj-2l@be1.lrz>
In-Reply-To: <E1E2GAN-0003Pj-2l@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Hiroyuki Machida <machida@sm.sony.co.jp> wrote:
> 
> 
>>For newly created and/or modified files/dirs, system can utilize
>>full posix attributes, because memory resident inode storage can
>>hold those. After umount-mount cycle, system may lose some
>>attributes to preserve VFAT format.
> 
> 
> Inodes may be reclaimed, therefore you might also lose some attributes at
> runtime. For your users, that will look like a heisenbug. A similar bug
> has been reported for procfs. Is your implementation affected?

Yes.
Thank you, pointed it out. So I need to select
	1) restric attribute even in mamory
or
	2) pinn inode in memory during mount
		(I think it's not good idea)

I'll revise the patch with 1).

>>- Special file
>>        To distinguish special files, look if this fat dir entry 
>>        has ATTR_SYS, first. If it has ATTR_SYS, then check
>>        1st. LSB bit in ctime_cs, refered as "special file flag".
>>        If set,  this file is created under VFAT with "posix_attr". 
>>        Look up TYPE field to decide special file type.
>>        This spcial file detection mothod has some flaw to make
>>        potential confusion. E.g. some system file created under
>>        dos/win may be treated as special file.  However in most case,
>>        user don't create system file under dos/win.
> 
> 
> You can add additional magic, e.g.: nodes must be empty, except for symlinks
> which must be not larger than 4KB (current PATH_MAX?). This will get rid
> of io.sys, logo.sys etc.\. If you want to be really sure, prepend a magic
> code to the on-disk representation of symlinks.

Please confirm my understanding.
You sugessted that symlink should not have ATTR_SYS, to prevent
some over 4KB files created in DOS/WIN to be treated as symlinks?

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		
SSW Dept. HENC, Sony Corp.

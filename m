Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030612AbWHIKJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030612AbWHIKJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030631AbWHIKJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:09:52 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:28012 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030612AbWHIKJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:09:51 -0400
Message-ID: <44D9B4C4.90304@sw.ru>
Date: Wed, 09 Aug 2006 14:11:16 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, viro@zeniv.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mishin Dmitry <dim@openvz.org>
Subject: Re: [PATCH] move IMMUTABLE|APPEND checks to notify_change()
References: <44D87907.6090706@sw.ru> <20060808203814.GO29920@ftp.linux.org.uk>
In-Reply-To: <20060808203814.GO29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, Aug 08, 2006 at 03:44:07PM +0400, Kirill Korotaev wrote:
> 
>>[PATCH] move IMMUTABLE|APPEND checks to notify_change()
>>
>>This patch moves lots of IMMUTABLE and APPEND flag checks
>>scattered all around to more logical place in notify_change().
> 
>  
> NAK.  For example, you are allowed to do unames(file, NULL) on
> any file you own or can write to, whether it's append-only or
> not.  With your change that gets -EPERM.
> 

Does such check in notify_change() looks better for you?

notify_change():
        if (IS_IMMUTABLE(inode))
                return -EPERM;
        if (IS_APPEND(inode) &&
                        (ia_valid & ~(ATTR_CTIME | ATTR_MTIME | ATTR_ATIME)))
                return -EPERM;

Thanks,
Kirill

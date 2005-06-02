Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFBHzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFBHzc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFBHzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:55:32 -0400
Received: from pcmath126.unice.fr ([134.59.10.126]:57986 "EHLO
	pcmath126.unice.fr") by vger.kernel.org with ESMTP id S261203AbVFBHzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:55:24 -0400
Message-ID: <429EB537.4060305@unice.fr>
Date: Thu, 02 Jun 2005 09:28:55 +0200
From: XIAO Gang <xiao@unice.fr>
Organization: =?ISO-8859-1?Q?Universit=E9_de_Nice_-_Sophia_Anti?=
 =?ISO-8859-1?Q?polis?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, fr, zh-CN, zh-TW
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Suggestion on "int len" sanity
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:

>> On the other hand, when a variable is named "len" or "length", it is 
>> usually used for length and never should go negative. So could I suggest 
>> that the declarations of these variables to be uniformized to "size_t", 
>> via a gradual but sysmatic cleanup?

> Probably true for most cases, but be careful of code which would use
> -1 to report some errors if such thing exists.

I agree that they are probably not all replaceable, and care must be taken.

Examples:

1. In the types of sys_[gs]ethostname, sys_[gs]etdomainname, "int len" could be replaced
by "unsigned int" or "size_t" and sanity check simplified.

2. In mm/shmem.c, shmem_symlink(), we have "len = strlen(symname) + 1;". Although it is highly
improbable that strlen(symname) overflows, it is more correct to declare "size_t len;".

3. The similar situation occurs in fs/namei.c, vfs_readlink(). Here it does not matter if len
is declared to be unsigned, but for size_t, we have to take care about the size of size_t.

-- 

XIAO Gang (~{P$8U~})                          xiao@unice.fr
          home page: pcmath126.unice.fr/xiao.html 




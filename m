Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSLKBQz>; Tue, 10 Dec 2002 20:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSLKBQz>; Tue, 10 Dec 2002 20:16:55 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32177 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266939AbSLKBQy>;
	Tue, 10 Dec 2002 20:16:54 -0500
Message-ID: <3DF69383.3090602@us.ibm.com>
Date: Tue, 10 Dec 2002 17:23:15 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix strange stack calculation for secondary cpus
References: <Pine.LNX.4.44.0212110048360.1821-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0212110048360.1821-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Tue, 10 Dec 2002, Dave Hansen wrote:
> 
>>in arch/i386/kernel/smpboot.c:
>>stack_start.esp = (void *) (1024 + PAGE_SIZE + (char *)idle);
>>
>>This causes problems when I switch to 4k stacks?  What is supposed to 
>>be going on here?  Why point esp into the middle of the stack?  If you 
>>wanted to do that, why not just use PAGE_SIZE>>2?
>>
> To avoid mysterious magic numbers, I chose instead to start it immediately
> below that area i.e. set the top esp here to the bottom esp there.  That
> worked fine for 2.4, I don't see why the same shouldn't work for 2.5.

It should.  I just want to be able to use arbitrary stack sizes.

> Whereas with your patch, you might be overwriting that area.
> So below I've munged your patch into what we found worked back then.

Agreed.  I was really just trying to eliminate the magic number 
without much real knowledge about what was going on.

Would you like to send your patch on to Alan or Linus?
-- 
Dave Hansen
haveblue@us.ibm.com


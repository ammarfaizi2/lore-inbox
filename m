Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265721AbTFSHSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 03:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265725AbTFSHQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 03:16:56 -0400
Received: from terminus.zytor.com ([63.209.29.3]:63978 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265724AbTFSHQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 03:16:46 -0400
Message-ID: <3EF16699.2040900@zytor.com>
Date: Thu, 19 Jun 2003 00:30:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: David Howells <dhowells@cambridge.redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS autmounter support
References: <2849.1056007206@warthog.warthog>
In-Reply-To: <2849.1056007206@warthog.warthog>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
>>>That _is_ actually true. Doing "ls -l" in that directory would otherwise
>>>cause a mount storm.
>>>
>>
>>It's not.  ls -l and all the GUI tools do lstat(), not stat().
> 
> 
> Sorry... you're correct. That should have been "ls -F" or "ls --color", both
> of which are, I believe, commonly used - _they_ definitely use stat() as well
> as lstat().
> 

Only if S_ISLNK.

> 
>>>follow_link resolving to itself? Surely that'll cause ELOOP very quickly?
>>>And where does this "dummy directory inode" live?
>>
>>Nope.  You can follow_link() nonrecursively.  You need a dummy directory 
>>inode to mount upon anyway.
> 
> You're right about follow_link() not recursing... it would have to recurse
> itself, and so can avoid that. However, if it only ever follows to itself, how
> does that help? That never actually gets you anywhere... It needs to trigger a
> mount at some point.
> 
> Or do you mean it should follow to an arbitrary (disconnected, otherwise it
> changes the topology from what the AFS admin required) dentry with a dummy
> directory inode attached to it?
> 

You could do that if you wanted to, but it doesn't need to.

	-hpa



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWBLVU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWBLVU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 16:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWBLVU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 16:20:57 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:52632 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750945AbWBLVU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 16:20:57 -0500
Message-ID: <43EFA63B.30907@tlinx.org>
Date: Sun, 12 Feb 2006 13:18:51 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk>
In-Reply-To: <20060212180601.GU27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
>> Should it be something like Glib's '20' or '255'?
>>     
> 	20 or 255 - not feasible (we'll get stack overflow from hell).
>   
How much stack is used/iteration?  It appears we have a local pointer in
__do_follow_link, and 2 passed parameters/call + call-returns ->5
pointers/iteration.  "Forty" entries would seem to take 200 pointers or
800 bytes of stack space?  A limit of 20 would use 400 bytes?

If the algorithm was rewritten to be iterative with a stack, that would
seem to reduce memory usage by 40%, (2 "return" addresses out of 5
addresses).  Depends on how tight stack space is.  If push came to
"shove" couldn't the iterative stack be allocated out of the the general
purpose kernel-memory allocator and not live on the stack, alleviating
the stack pressure entirely?

It doesn't seem it causes an outrageous additional load on the stack as
is, though dynamically allocating the structures out of general memory
would seem to eliminate the problem (if there is one).



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262366AbUKWDbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbUKWDbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbUKVVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:41:15 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:43166 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262349AbUKVVcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:32:22 -0500
Message-ID: <41A24FB2.4010909@tmr.com>
Date: Mon, 22 Nov 2004 15:44:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: on the concept of COW
References: <1100947100.4038.41.camel@myLinux>
In-Reply-To: <1100947100.4038.41.camel@myLinux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jagadeesh Bhaskar P wrote:
> Hi,
> 
>  When a process forks, every resource of the parent, including the
> virtual memory is copied to the child process. The copying of VM uses
> copy-on-write(COW). I know that COW comes when a write request comes,
> and then the copy is made. Now my query follows:
> 
> How will the copy be distributed. Whether giving the child process a new
> copy of VM be permanent or whether they will be merged anywhere? And
> shouldn't the operations/updations by one process be visible to the
> other which inherited the copy of the same VM?

The copies are separate and distinct, and the whole concept of the fork 
is to have an independent process. Operations are (deliberately) not 
visible from one process to another, that need can be met by the 
shmget/shmat system calls (share on swap), mmap call (share on 
filesystem), or by just using threads instead of fork. There may be 
performance hits one way or the other, on large systems swap may be 
faster than a filesystem, particularly /tmp if you use that.
> 
> How can this work? Can someone please help me on this regard?
> 
Man pages on shmget and mmap will get you started.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me


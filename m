Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUEKPTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUEKPTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbUEKPTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:19:16 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:47904 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264782AbUEKPTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:19:14 -0400
Message-ID: <40A0EFC0.1040609@sgi.com>
Date: Tue, 11 May 2004 10:22:40 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Silviu Marin-Caea <silviu@genesys.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: dynamic allocation of swap disk space
References: <fa.n6pggn5.84en31@ifi.uio.no>
In-Reply-To: <fa.n6pggn5.84en31@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Silviu Marin-Caea wrote:
>
> 
> My desktop has been thrashing the disk for a couple of hours because
> the swap space was exhausted.  And I have the ambition to leave it alone
> to see if it ever comes out of the thrashing.  Of course, it's not usable
> at all during this time, I'm writing this on the laptop.
> 
>

You've got a couple problems mixed together here.

(1)  Swap space fills up because you have overcommitted memory.  In principle, 
filling up swap space has nothing to do with "thrashing".
(2)  "thrashing" is a characteristic of a poorly performing program in a
demand paging virtual memory system typically caused by trying to run a 
program with a resident size that is smaller than required.  Systems can 
thrash without filling up swap space.  It is true that systems can thrash AND 
fill up swap space, but it is not always so.

You either need (1)  more main memory, (2) reduce the number of programs you 
are running simultaneously, or (3) better behaving programs, or all three. 
Increasing the amount of swap space will just use more disk.  It won't cause 
your system to stop thrashing since that is driven by what is going on in 
memory, not what is going on on the disk.

Anyway, if swap space is full, then main memory is (nearly) full, and this is 
not a good time to do major surgery to your file system (e. g. increase the 
size of the swap space).  You may not be able to allocate the required memory 
to complete that job and then your system will crash.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUBIMfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 07:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUBIMfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 07:35:38 -0500
Received: from smtp.vnoc.murphx.net ([217.148.32.26]:56047 "HELO
	smtp.vnoc.murphx.net") by vger.kernel.org with SMTP id S265105AbUBIMf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 07:35:27 -0500
Message-ID: <40277FAA.5040804@gadsdon.giointernet.co.uk>
Date: Mon, 09 Feb 2004 12:40:10 +0000
From: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040206
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
CC: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module - problem
 with 2.6.3-rc1
References: <fa.h2vc33f.192ajhf@ifi.uio.no> <fa.j0on9f7.13he7o9@ifi.uio.no>
In-Reply-To: <fa.j0on9f7.13he7o9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest VMware update -
http://ftp.cvut.cz/vmware/vmware-any-any-update50.tar.gz
fixes this problem, without the need to mess around with the contents of
...include/asm-i386/unistd.h

Robert Gadsdon




Robert Gadsdon wrote:
> I had this problem when recompiling VMware WS 4.0.5 with kernel 
> 2.6.3-rc1 (x86 system).   2.6.2 and earlier had been OK..
> 
> I found the following reference relating a similar problem with 2.6.1-mm5:
> 
> http://www.vmware.com/community/thread.jspa?threadID=1976&messageID=8243
> 
> Re-inserting
> #define __NR__exit __NR_exit
> and
> static inline _syscall1(void,_exit,int,exitcode)
> in ...include/asm-i386/unistd.h fixed the problem for me.   I do _not_ 
> know if this is an acceptable solution, as there may be other 
> implications for the removal of this code in 2.6.3-rc1...
> 
> Robert Gadsdon.
> 
> Felipe Alfaro Solana wrote:
> 
>> Hi!
>>
>> After installing VMware Workstation 4.5.0-7174 and running
>> vmware-config.pl, I get the following error when trying to insert
>> vmmon.ko into the kernel:
>>
>> vmmon: Unknown symbol _exit
>>
>> What can I use instead of _exit(code) inside a module?
>> Thanks!
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


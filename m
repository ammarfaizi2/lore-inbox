Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVDYLPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVDYLPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVDYLPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:15:46 -0400
Received: from smtpout.mac.com ([17.250.248.86]:4860 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262582AbVDYLPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:15:37 -0400
In-Reply-To: <426CC8F7.8070905@lab.ntt.co.jp>
References: <4263275A.2020405@lab.ntt.co.jp> <m1y8b9xyaw.fsf@muc.de> <426C51C4.9040902@lab.ntt.co.jp> <e83d0cb60cb50a56b38294e9160d7712@mac.com> <426CC8F7.8070905@lab.ntt.co.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd952291c8bd52329fb8ec0fd81c8c5c@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Date: Mon, 25 Apr 2005 07:15:23 -0400
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 25, 2005, at 06:39, Takashi Ikebe wrote:
> Kyle Moffett wrote:
>
>> If you want that exact functionality, do this:
>>
>> At program start, spawn a new thread:
>> 1) Open a UNIX socket (/var/run/someapp_live_patch.sock)
>> 2) poll() that socket for a connection.
>> 3) When you get a connection, do your own security checks
>> 4) If it's ok, then map the specified file into memory
>> 5) Read a table of crap to patch from the file
>> 6) Do the patching, being careful to avoid the millions of
>> races involved for each CPU, *especially* regarding the
>> separate icache and dcache on CPUs like PPC and such.
>> 7) Go back to step 2
> Kyle, thank you so much for your detailed information.
> If you design completely new software, your suggestion is very useful!
>
> Unfortunately, we carrier have very many exiting software and try to 
> run
> on Linux.
> We need to seek the way which can apply to exiting software also...

If you notice, the above method has only minimal changes from
your mmap3 stuff, except without needing kernel support. One
thing to remember, though, as there _is_ a very clean method
to do this from userspace, therefore you are not likely to
get much sympathy on this list.

I suggest you try adding a new hotpatch thread to your code,
as above, then use it to implement the mmap3 and other tasks
necessary for live patching instead of in kernel space.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSLQTYt>; Tue, 17 Dec 2002 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbSLQTYt>; Tue, 17 Dec 2002 14:24:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39430 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265895AbSLQTYs>; Tue, 17 Dec 2002 14:24:48 -0500
Message-ID: <3DFF7BCD.9040901@transmeta.com>
Date: Tue, 17 Dec 2002 11:32:29 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171115450.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171115450.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 17 Dec 2002, Linus Torvalds wrote:
> 
>>Hmm.. Which system calls have all six parameters? I'll have to see if I
>>can find any way to make those use the new interface too.
> 
> 
> The only ones I found from a quick grep are
>  - sys_recvfrom
>  - sys_sendto
>  - sys_mmap2()
>  - sys_ipc()
> 
> and none of them are of a kind where the system call entry itself is the
> biggest performance issue (and sys_ipc() is deprecated anyway), so it's
> probably acceptable to just use the old interface for them.
> 

recvfrom() and sendto() can also be implemeted as sendmsg() recvmsg() if
one really wants to.

What one can also do is that a sixth argument, if one exists, is passed
on the stack (i.e. in (%ebp), since %ebp contains the stack pointer.)

	-hpa


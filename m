Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbTDROEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTDROEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:04:32 -0400
Received: from watch.techsource.com ([209.208.48.130]:46055 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263048AbTDROEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:04:31 -0400
Message-ID: <3EA00C38.2080308@techsource.com>
Date: Fri, 18 Apr 2003 10:31:20 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
References: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com> <3E9F3D6F.9030501@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff Garzik wrote:

[snip]

>-		case 20:
>-			*(unsigned long *)to = *(const unsigned long *)from;
>-			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
>-			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
>-			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
>-			*(4+(unsigned long *)to) = *(4+(const unsigned long *)from);
>-			return to;
>-	}
>+	if (n <= 128)
>+		return __builtin_memcpy(to, from, n);
>+
> #define COMMON(x) \
> __asm__ __volatile__( \
> 	"rep ; movsl" \
>  
>

Ignorant questions since I haven't been following the discussion:  Does 
this work with unaligned copies?  Does it work well?  What's better, 
letting the CPU do realignment, or writing the code to do bit shifts so 
that both reads and writes are aligned?



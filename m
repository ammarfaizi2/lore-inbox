Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVDYNCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVDYNCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVDYNCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:02:11 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:2281 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262599AbVDYNCB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:02:01 -0400
Message-ID: <426CEA3B.50300@tiscali.de>
Date: Mon, 25 Apr 2005 15:01:47 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
CC: Rene Rebe <rene@exactcode.de>, Linus Torvalds <torvalds@osdl.org>,
       git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
References: <426CD1F1.2010101@tiscali.de> <426CD703.5040009@exactcode.de> <426CE904.9010505@tiscali.de>
In-Reply-To: <426CE904.9010505@tiscali.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias-Christian Ott wrote:
> Rene Rebe wrote:
> 
>> Hi,
>>
>> Matthias-Christian Ott wrote:
>>
>>> The "git" didn't try store small variables, which aren't referenced, 
>>> in the processor registers. It also didn't use the size_t type. I 
>>> corrected a C++ style comment too.
>>
>>
>>
>> Well, modern compilers take register as a non-binding hint. Your 
>> register storage specification for those loop counters will not make 
>> any change. You have not looked into the resulting binary?
>>
>> Also // is valid C99 ...
>>
>> Yours,
>>
> But if you use only /* */ comments and there's a // comment it looks 
> ugly :).
> 
> I've disassembled the code and it for me (I'm not a professional 
> assembler coder) it looks like it's stored in a register because the ebp 
> offsets are smaller and the gcc (4.0) wouldn't cause an error if you 
> reference them.
> 
> Matthias-Christian Ott
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
Here's some example code (diff of the assembler codes) which shows what 
I mean:

-       movl    %eax, -8(%ebp)
+       movl    %eax, -4(%ebp)
[..]
-       leal    1(%eax), %ecx
-       movl    -52(%ebp), %edx
+       leal    1(%eax), %edx
         movl    12(%ebp), %eax
-       subl    %edx, %eax
-       movl    %eax, %edx
-       movl    -52(%ebp), %eax
+       movl    %eax, %ecx
+       subl    -80(%ebp), %ecx
+       movl    -80(%ebp), %eax
         sall    $2, %eax
         movl    %eax, %ebx
         addl    8(%ebp), %ebx


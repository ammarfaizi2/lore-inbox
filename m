Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTLOPwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLOPwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:52:45 -0500
Received: from fmr99.intel.com ([192.55.52.32]:20710 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263745AbTLOPwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:52:43 -0500
Message-ID: <3FDDD8C6.3080804@intel.com>
Date: Mon, 15 Dec 2003 17:52:38 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I almost convinced it may be removed.
My point is, this initialization with 0 cost nothing. Readability and 
clearness of code do matter, on my opinion. I think when one states 
explicitly he expect variable to have 0 value, it is better then use 
implicit rules.

To illustrate zero cost, I did the following test:
[tmp]$ cat t.c; gcc -S t.c; cat t.s
static int a1=0;
static int a2;
/* EOF */

    .file    "t.c"
    .local    a1
    .comm    a1,4,4
    .local    a2
    .comm    a2,4,4
    .section    .note.GNU-stack,"",@progbits
    .ident    "GCC: (GNU) 3.3.1 20030811 (Red Hat Linux 3.3.1-1)"

As you can see, assembly code is identical, compiler did this trivial 
optimization for me.

Vladimir.

Mark Hahn wrote:

>>>>+static void* rrbar_virt=NULL;
>>>>        
>>>>
>>>Do not bother initializing static variables to zero.  This just wastes 
>>>bss space, since these variables are automatically zeroed for you, 
>>>anyway.
>>>      
>>>
>>I did not found this feature in standard. More, future versions of gcc 
>>will give at least warning, if not error, like "use of uninitialized 
>>variable". Many good sources also say it is good practice to initialize 
>>all variables. I rely on its value later. I' ll keep it as is unless 
>>really strong arguments provided.
>>    
>>
>
>it'll get your code rejected.  static variables are always, everywhere,
>initialized to zero (OK, probably not embedded environments).  this is 
>a code standard, not a matter of taste.
>
>  
>


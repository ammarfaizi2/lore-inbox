Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbUKKBXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbUKKBXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUKKBXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:23:46 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:23005 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262162AbUKKBXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:23:22 -0500
Message-ID: <4192BF01.1090509@cyberone.com.au>
Date: Thu, 11 Nov 2004 12:23:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Schmidt <zaphodb@zaphods.net>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel
 2.6.9 Multiple Page Allocation Failures
References: <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org> <20041110020327.GE20754@zaphods.net> <419197EA.9090809@cyberone.com.au> <20041110102854.GI20754@zaphods.net> <20041110120624.GF28163@zaphods.net> <20041110085831.GB10740@logos.cnet> <20041110124810.GG28163@zaphods.net>
In-Reply-To: <20041110124810.GG28163@zaphods.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stefan Schmidt wrote:

>On Wed, Nov 10, 2004 at 06:58:31AM -0200, Marcelo Tosatti wrote:
>
>>>>>Can you try the following patch, please? It is diffed against 2.6.10-rc1,
>>>>>
>>>I did. No apparent change with mm4 and vm.min_free_kbytes = 8192. I will try
>>>latest bk next.
>>>
>
>>>>I set it back to CONFIG_PACKET_MMAP=y and if the application does not freeze
>>>>for some hours at this load we can blame at least this issue (-1 EAGAIN) on
>>>>that parameter.
>>>>
>>>Nope, that didn't change anything, still getting EAGAIN, checked two times.
>>>
>>Its not clear to me - do you have Nick's watermark patch in? 
>>
>Yes i have vm.min_free_kbytes=8192 and Nick's patch in mm4. I'll try
>rc1-bk19 with his restore-atomic-buffer patch in a few minutes.
>
>

You'll actually want to increase min_free_kbytes in order to have the same
amount of memory free as 2.6.8 did.

Start by applying my patch and using the default min_free_kbytes. Then 
increase
it until the page allocation failures stop, and let us know what the end 
result
was.

BTW we should probably have a message in the page allocation failure path
to tell people to try increasing /proc/sys/vm/min_free_kbytes...


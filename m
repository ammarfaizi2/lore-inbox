Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbUKLMKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUKLMKt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 07:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbUKLMKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 07:10:49 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:18407 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262514AbUKLMJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 07:09:34 -0500
Message-ID: <4194A7F9.5080503@cyberone.com.au>
Date: Fri, 12 Nov 2004 23:09:29 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, zaphodb@zaphods.net,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
References: <20041103222447.GD28163@zaphods.net> <20041104121722.GB8537@logos.cnet> <20041104181856.GE28163@zaphods.net> <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109224423.GC18366@mail.muni.cz> <20041109203348.GD8414@logos.cnet> <20041110212818.GC25410@mail.muni.cz> <20041110181148.GA12867@logos.cnet> <20041111214435.GB29112@mail.muni.cz>
In-Reply-To: <20041111214435.GB29112@mail.muni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Lukas Hejtmanek wrote:

>On Wed, Nov 10, 2004 at 04:11:48PM -0200, Marcelo Tosatti wrote:
>
>>OK, do you have Nick watermark fixes in? 
>>
>>They increase the GFP_ATOMIC buffer (memory reserved for GFP_ATOMIC allocations)
>>significantly, which is exactly the case here.
>>
>>Its in Andrew's -mm tree already (the last -mm-bk contains it).
>>
>>Its attached just in case - hope it ends this story.
>>
>
>Well today it reported page allocation failure again. I remind that I have
>increased socket buffers:
>/sbin/sysctl -w net/core/rmem_max=8388608
>/sbin/sysctl -w net/core/wmem_max=8388608
>/sbin/sysctl -w net/core/rmem_default=1048576
>/sbin/sysctl -w net/core/wmem_default=1048576
>/sbin/sysctl -w net/ipv4/tcp_window_scaling=1
>/sbin/sysctl -w net/ipv4/tcp_rmem="4096 1048576 8388608"
>/sbin/sysctl -w net/ipv4/tcp_wmem="4096 1048576 8388608"
>/sbin/ifconfig eth0 txqueuelen 1000
>
>I've tried to incdease min_free_kbytes to 10240 and it did not help :(
>
>

OK. Occasional page allocation failures are not a problem, although
if it is an order-0 allocation it may be an idea to increase
min_free_kbytes a bit more.

I think you said earlier that you had min_free_kbytes set to 8192?
Well after applying my patch, the memory watermarks get squashed
down, so you'd want to set it to at least 16384 afterward. Maybe
more.

That shouldn't cause it to actually keep more memory free than
2.6.8 did with an 8192 setting.



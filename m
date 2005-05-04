Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVEDVAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEDVAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVEDU6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:58:01 -0400
Received: from p4.gsnoc.net ([209.51.147.210]:11749 "EHLO p4.gsnoc.net")
	by vger.kernel.org with ESMTP id S261643AbVEDUyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:54:40 -0400
Message-ID: <42793688.2090700@cachola.com.br>
Date: Wed, 04 May 2005 17:54:32 -0300
From: =?ISO-8859-1?Q?Andr=E9_Pereira_de_Almeida?= <andre@cachola.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alexander Nyberg <alexn@dsv.su.se>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: A patch for the file kernel/fork.c
References: <4278E03A.1000605@cachola.com.br>	<20050504175457.GA31789@taniwha.stupidest.org>	<427913E4.3070908@cachola.com.br>	<20050504184318.GA644@taniwha.stupidest.org>	<42791CD2.5070408@cachola.com.br>	<1115234213.2562.28.camel@localhost.localdomain> <20050504124104.3573e7f3.akpm@osdl.org>
In-Reply-To: <20050504124104.3573e7f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - p4.gsnoc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - cachola.com.br
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Alexander Nyberg <alexn@dsv.su.se> wrote:
>  
>
>>>[4300748.423000] Call Trace:
>>>[4300748.423000]  [<c0104bfa>] show_stack+0x7a/0x90
>>>[4300748.423000]  [<c0104d7d>] show_registers+0x14d/0x1b0
>>>[4300748.423000]  [<c0104fcc>] die+0x14c/0x2c0
>>>[4300748.423000]  [<c0118b6f>] do_page_fault+0x31f/0x638
>>>[4300748.423000]  [<c01046df>] error_code+0x4f/0x54
>>>[4300748.423000]  [<c02b88fd>] tty_wakeup+0x5d/0x60
>>>
>>>I think that maybe it's good to put a:
>>>       WARN_ON(!mm);
>>>but a BUG_ON or without this patch, the kernel will halt, even if the 
>>>problem is not so severe.
>>>      
>>>
>>Patching up the kernel hiding things that must not happen is not the way
>>to go. All kernel bugs are severe (as you just showed us!). Adding extra
>>checks like your original patch did may even cause much more harm
>>because it may hide other problems causing silent problems.
>>    
>>
>
>If I understand Andre correctly, his patch will prevent infinite recursion
>in the oops path - if some process oopses after having run exit_mm().
>
>If so then it's a reasonable debugging aid.  Although there might be better
>places to do it, such as
>
>	if (!current->i_tried_to_exit++)
>		return;
>
>in do_exit().   Dunno.
>
>  
>
I agree. If you need this patch, the you are in already in trouble, your 
kernel had already oopsed, your system is halted and you can't even send 
a bug report because you can't read read the call trace (it's an 
infinite recursion) and you can see only the end of it. It's not 
intended to hide the problem, the problem will be already in your screen.
André.

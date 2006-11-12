Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932889AbWKLNzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932889AbWKLNzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbWKLNzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:55:20 -0500
Received: from il.qumranet.com ([62.219.232.206]:50606 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932889AbWKLNzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:55:19 -0500
Message-ID: <455727C5.9070400@qumranet.com>
Date: Sun, 12 Nov 2006 15:55:17 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
References: <200611112334.28889.bero@arklinux.org> <200611121436.15492.bero@arklinux.org> <455724FD.7070600@qumranet.com> <200611121450.24859.bero@arklinux.org>
In-Reply-To: <200611121450.24859.bero@arklinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> On Sunday, 12. November 2006 14:43, Avi Kivity wrote:
>   
>> 'sel' is a variable, so gcc can't provide it as an immediate operand.
>> Specifying it as "rm" instead of "g" would have been better, but can't
>> have any real influence.
>>     
>
> Specifying it as "rm" instead of "g" does fix it -- patch attached.
>
>   
>> Well, for the code you posted in in the gcc bug, it probaby generated
>> something like
>>
>>     mov $0, %fs
>>
>> which is indeed invalid assembly.  But the kvm miscompile is something
>> else (running out of registers or something like that).
>>     
>
> What am I overlooking? The code is the exact same (except I replaced "u16" 
> with "unsigned short" to avoid the #include), and produces the exact same 
> error message, and the fix is the same ("g" -> "rm").
>   

Well, since it works, I guess I'm overlooking something.  Maybe it's 
just a bad error message from gcc.

I'll apply this.  Thanks!

> ------------------------------------------------------------------------
>
> --- linux-2.6.18/drivers/kvm/kvm_main.c.ark	2006-11-12 14:40:09.000000000 +0100
> +++ linux-2.6.18/drivers/kvm/kvm_main.c	2006-11-12 14:44:57.000000000 +0100
> @@ -150,12 +150,12 @@
>  
>  static void load_fs(u16 sel)
>  {
> -	asm ("mov %0, %%fs" : : "g"(sel));
> +	asm ("mov %0, %%fs" : : "rm"(sel));
>  }
>  
>  static void load_gs(u16 sel)
>  {
> -	asm ("mov %0, %%gs" : : "g"(sel));
> +	asm ("mov %0, %%gs" : : "rm"(sel));
>  }
>  
>  #ifndef load_ldt
>   


-- 
error compiling committee.c: too many arguments to function


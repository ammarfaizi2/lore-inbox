Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUFOEen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUFOEen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 00:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265246AbUFOEen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 00:34:43 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:26052 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264983AbUFOEel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 00:34:41 -0400
Message-ID: <40CE7C5F.2070405@tomt.net>
Date: Tue, 15 Jun 2004 06:34:39 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nuno Monteiro <nuno@itsari.org>, Gianni Tedesco <gianni@scaramanga.co.uk>,
       marcelo.tosatti@cyclades.com
Subject: Re: Local DoS attack on i386
References: <200406121159.28406.manuel@todo-linux.com> <1087221517.3375.3.camel@sherbert> <20040614142001.GA3032@hobbes.itsari.int>
In-Reply-To: <20040614142001.GA3032@hobbes.itsari.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Monteiro wrote:
> The same fix should be applied to 2.4. I'm running locally a very
> hacked version of 2.4.22 with it and it survives that crash.c program.
> 
> Here's the diff. Marcelo, please merge.
> 
> 
> --- linux-2.4.27-pre5/include/asm-i386/i387.h~fix-x86-clear_fpu-macro	2004-06-14 15:12:13.909059344 +0100
> +++ linux-2.4.27-pre5/include/asm-i386/i387.h	2004-06-14 15:12:45.970185312 +0100
> @@ -34,7 +34,7 @@ extern void kernel_fpu_begin(void);
>  
>  #define clear_fpu( tsk ) do { \
>  	if ( tsk->flags & PF_USEDFPU ) { \
> -		asm volatile("fwait"); \
> +		asm volatile("fnclex ; fwait"); \
>  		tsk->flags &= ~PF_USEDFPU; \
>  		stts(); \
>  	} \

You're missing x86-64.

Complete patches are up at <http://tomt.net/kernel/clear_fpu/> - these 
covers 2.4 and 2.6, plus i386 and x86-64.

But I guess Marcelo would want the x86-64 part to come through ak.

-- 
Cheers,
André Tomt

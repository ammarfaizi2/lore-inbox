Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSLQSgA>; Tue, 17 Dec 2002 13:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLQSgA>; Tue, 17 Dec 2002 13:36:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21731
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265275AbSLQSf7>; Tue, 17 Dec 2002 13:35:59 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
In-Reply-To: <3DFF6501.3080106@redhat.com>
References: <Pine.LNX.4.44.0212170858510.2702-100000@home.transmeta.com> 
	<3DFF6501.3080106@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 19:23:50 +0000
Message-Id: <1040153030.20804.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 17:55, Ulrich Drepper wrote:
> But there is a way: if I'm using
> 
>    #define makesyscall(name) \
>         movl $__NR_##name, $eax; \
>         call 0xfffff000-__NR_##name($eax)
> 
> and you'd put at address 0xfffff000 the address of the entry point the
> wrappers wouldn't have any problems finding it.

Is there any reason you can't just keep the linker out of the entire
mess by generating

	.byte whatever
	.dword 0xFFFF0000

instead of call ?



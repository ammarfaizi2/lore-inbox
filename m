Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSL1AG1>; Fri, 27 Dec 2002 19:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265325AbSL1AG1>; Fri, 27 Dec 2002 19:06:27 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:16595 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S265305AbSL1AG0>;
	Fri, 27 Dec 2002 19:06:26 -0500
Date: Sat, 28 Dec 2002 01:14:43 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, davem@redhat.com
Subject: Re: [BUG+PATCH] binfmt_elf::create_elf_tables changes u_platform without refill
Message-ID: <20021228001443.GE2079@werewolf.able.es>
References: <20021227235835.GA2079@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021227235835.GA2079@werewolf.able.es>; from jamagallon@able.es on Sat, Dec 28, 2002 at 00:58:35 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.28 J.A. Magallon wrote:
> Hi all...
> 
[...]
> #if defined(__i386__) && defined(CONFIG_SMP)
>     if(smp_num_siblings > 1)
>         u_platform = u_platform - ((current->pid % 64) << 7);
> ///// So original u_platform with data is lost !!!
> #endif
> ...
[...]
> 
> One question: why the 64 value ? Because linux supports 64 processors ?
> Why not just 2, because you have two siblings at most ?
> 

Better, shouldn't this be NR_CPUS ? So you save half stack space on ia32,
or even more with CONFIG_NR_CPUS...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))

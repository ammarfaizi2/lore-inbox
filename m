Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbSLUAFs>; Fri, 20 Dec 2002 19:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLUAFs>; Fri, 20 Dec 2002 19:05:48 -0500
Received: from smtp07.iddeo.es ([62.81.186.17]:43399 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id <S261218AbSLUAFo>;
	Fri, 20 Dec 2002 19:05:44 -0500
Date: Sat, 21 Dec 2002 01:13:34 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-aa and LARGE Squid process -> SIGSEGV
Message-ID: <20021221001334.GA7996@werewolf.able.es>
References: <20021220114837.GC13591@charite.de> <20021220223754.GA10139@werewolf.able.es> <20021220225733.GE31070@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021220225733.GE31070@charite.de>; from Ralf.Hildebrandt@charite.de on Fri, Dec 20, 2002 at 23:57:33 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.20 Ralf Hildebrandt wrote:
>* J.A. Magallon <jamagallon@able.es>:
>
>> Normal. You are running OOM. Look at what you do:
>
>But that manifests itself in a segfault? The kernel never logs an OOM
>in the logs.
>

Well, I used the OOM term, but I suspect it 'technically' only applies
to the situation when a kernel thread needs memory to do its work, and
it can not allocate it. The system can not continue without that memory,
you are OOM, and the OOM killer will begin to kill other things.

For user space memory, there is no real OOM state. The system (glibc) just
does not give you the memory, returns NULL in the malloc, and it is your
responsibility to check malloc's return value. If you do not check it,
you try to access a null pointer and _bang_. So in your case, after enough
iterations on malloc() without free(), it returns NULL and you fall into
a null pointer dereference.

AFAIK.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262195AbSJNV1y>; Mon, 14 Oct 2002 17:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJNV1y>; Mon, 14 Oct 2002 17:27:54 -0400
Received: from smtp09.iddeo.es ([62.81.186.19]:44508 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S262195AbSJNV1l>;
	Mon, 14 Oct 2002 17:27:41 -0400
Date: Mon, 14 Oct 2002 23:33:32 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at arch/i386/kernel/apm.c:1699!
Message-ID: <20021014213332.GA2053@werewolf.able.es>
References: <20021014144941.GA1217@stingr.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021014144941.GA1217@stingr.net>; from i@stingr.net on Mon, Oct 14, 2002 at 16:49:41 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=KOI8-R
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


On 2002.10.14 Paul P Komkoff Jr wrote:
>------------[ cut here ]------------
>kernel BUG at arch/i386/kernel/apm.c:1699!
>
>#ifdef CONFIG_SMP
>        /* 2002/08/01 - WT
>         * This is to avoid random crashes at boot time during initialization
>         * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
>         * Some bioses don't like being called from CPU != 0.
>         * Method suggested by Ingo Molnar.
>         */
>        if (smp_processor_id() != 0) {
>                current->cpus_allowed = 1;
>                schedule();
>                if (unlikely(smp_processor_id() != 0))
>                        BUG();
>        }
>#endif
>
>Why ? :()
>
>2.5.42-mm2, 2xPPro-233, etc ...
>

Bug in apm vs O1-scheduler. The apm task is moved from processor 0.
I took the fix from -ac tree. Just diff kernel/apm.c from -mm and from
-ac. That worked for me for 2.4 kernels. Perhaps 2.5 needs some additional
fix in other files. (err, I suppose that fix is in Alan's 2.5 tee also...)

Hope this helps.

Anyways, patch for 2.4 attached. I suppose it won't apply on 2.5, but you
can try...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))

--MGYHOYXEY6WxJCY8
Content-Type: application/x-bzip
Content-Disposition: attachment; filename="17-apm-O1-sched.bz2"
Content-Transfer-Encoding: base64

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
/F3JFOFCQBwtRmw=

--MGYHOYXEY6WxJCY8--

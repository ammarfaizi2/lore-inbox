Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbQLXRSA>; Sun, 24 Dec 2000 12:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130148AbQLXRRu>; Sun, 24 Dec 2000 12:17:50 -0500
Received: from [194.213.32.137] ([194.213.32.137]:25348 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129759AbQLXRRo>;
	Sun, 24 Dec 2000 12:17:44 -0500
Message-ID: <20001223233448.F541@bug.ucw.cz>
Date: Sat, 23 Dec 2000 23:34:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Chen <michaelc@turbolinux.com.cn>, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4015029078.19991223172443@turbolinux.com.cn>; from michael chen on Thu, Dec 23, 1999 at 05:24:43PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -Nur linux/include/asm-i386/system.h linux.new/include/asm-i386/system.h
> --- linux/include/asm-i386/system.h     Mon Dec 11 19:26:39 2000
> +++ linux.new/include/asm-i386/system.h Sat Dec 23 16:06:01 2000
> @@ -274,7 +274,14 @@
>  #ifndef CONFIG_X86_XMM
>  #define mb()   __asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
>  #else
> -#define mb()   __asm__ __volatile__ ("sfence": : :"memory")
> +#define mb()  do { \
> +       if ( cpu_has_xmm ) { \
                ~~~~~~~~~~~~~~~~~~

Cost of test may well be bigger than gain by using sfence...

Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

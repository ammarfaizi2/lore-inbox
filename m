Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315326AbSDWVIO>; Tue, 23 Apr 2002 17:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSDWVIN>; Tue, 23 Apr 2002 17:08:13 -0400
Received: from daimi.au.dk ([130.225.16.1]:31037 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315326AbSDWVIM>;
	Tue, 23 Apr 2002 17:08:12 -0400
Message-ID: <3CC5CD38.DC57DFA3@daimi.au.dk>
Date: Tue, 23 Apr 2002 23:08:08 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.9 remove warnings
In-Reply-To: <10704.1019533171@kao2.melbourne.sgi.com> <3CC5A8AF.432380E3@zip.com.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Is it not possible to fix it for all time?
> 
> --- linux-2.5.9/include/linux/compiler.h        Sun Apr 14 15:45:08 2002
> +++ 25/include/linux/compiler.h Tue Apr 23 11:27:37 2002
> @@ -10,8 +10,8 @@
>  #define __builtin_expect(x, expected_value) (x)
>  #endif
> 
> -#define likely(x)      __builtin_expect((x),1)
> -#define unlikely(x)    __builtin_expect((x),0)
> +#define likely(x)      __builtin_expect((x) != 0, 1)
> +#define unlikely(x)    __builtin_expect((x) != 0, 0)
> 
>  /* This macro obfuscates arithmetic on a variable address so that gcc
>     shouldn't recognize the original var, and make assumptions about it */

Wouldn't "!!(x)" make more sense here than "(x) != 0"?
(I don't like comparing pointers with integers.)

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk

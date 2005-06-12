Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFLTVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFLTVp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVFLTVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:21:05 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12679 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262642AbVFLQnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 12:43:17 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Mikael Pettersson <mikpe@csd.uu.se>, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 2.4.31 9/9] gcc4: fix i386 struct_cpy() warnings
Date: Sun, 12 Jun 2005 19:43:03 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200506121122.j5CBMjtH019768@harpo.it.uu.se>
In-Reply-To: <200506121122.j5CBMjtH019768@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506121943.03741.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 June 2005 14:22, Mikael Pettersson wrote:
> On i386 gcc4 generates a few compile-time warnings like:
> 
> process.c:556: warning: statement with no effect
> process.c:569: warning: statement with no effect
> 
> This is because the i386 struct_cpy() macro references an
> undefined variable when its two operands differ in size,
> in the hope of turning a runtime error into a link-time error.
> 
> However, a simple variable reference has no effect, which
> is why gcc4 complains.
> 
> The fix is to change it to a call to an undefined function.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
> 
>  include/asm-i386/string.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -rupN linux-2.4.31/include/asm-i386/string.h linux-2.4.31.gcc4-i386-struct_cpy-warnings/include/asm-i386/string.h
> --- linux-2.4.31/include/asm-i386/string.h	2001-08-12 11:35:53.000000000 +0200
> +++ linux-2.4.31.gcc4-i386-struct_cpy-warnings/include/asm-i386/string.h	2005-06-12 11:52:25.000000000 +0200
> @@ -337,7 +337,7 @@ extern void __struct_cpy_bug (void);
>  #define struct_cpy(x,y) 			\
>  ({						\
>  	if (sizeof(*(x)) != sizeof(*(y))) 	\
> -		__struct_cpy_bug;		\
> +		__struct_cpy_bug();		\
>  	memcpy(x, y, sizeof(*(x)));		\
>  })

1) Don't you need a void __struct_cpy_bug(void) declaration before this
   (as a matter of style, not correctness)?
2) Why __ ? It is not compiler- or library-special, why not
   BUG_struct_cpy_different_sizes() or something like this?
--
vda


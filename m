Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSEQCit>; Thu, 16 May 2002 22:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315358AbSEQCis>; Thu, 16 May 2002 22:38:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49671 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315338AbSEQCis>;
	Thu, 16 May 2002 22:38:48 -0400
Message-ID: <3CE46DF6.62EF67E0@zip.com.au>
Date: Thu, 16 May 2002 19:41:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Ghozlane Toumi <ghoz@sympatico.ca>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Fix BUG macro
In-Reply-To: Your message of "Thu, 16 May 2002 12:27:55 -0400."
	             <20020516162841.PYWL19243.tomts15-srv.bellnexxia.net@there> <E178XQX-0000tw-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> ...
>   __asm__ __volatile__( "ud2\n"         \
>                         "\t.word %c0\n" \
>                         "\t.long %c1\n" \
> -                        : : "i" (__LINE__), "i" (__FILE__))
> +                       "\t.long %c2\n" \
> +                        : : "i" (__LINE__), \
> +                       "i" (__stringify(KBUILD_BASENAME)), \
> +                       "i" (__FUNCTION__))

I'd share Hugh's concern on this one.  Adding the name of the
containing function to every BUG() expansion will increase
the size of .rodata.

Do you have before-and-after /usr/bin/size output?

-

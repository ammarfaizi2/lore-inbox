Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSEXGtI>; Fri, 24 May 2002 02:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317103AbSEXGtH>; Fri, 24 May 2002 02:49:07 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:9203 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317102AbSEXGtG>; Fri, 24 May 2002 02:49:06 -0400
Date: Fri, 24 May 2002 02:49:06 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] XBUG(comment) BUG enhancement
Message-ID: <20020524024906.A1547@redhat.com>
In-Reply-To: <E17B7Z0-0003cP-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 03:24:30PM +1000, Rusty Russell wrote:
>   __asm__ __volatile__(	"ud2\n"		\
> -			"\t.word %c0\n"	\
> +			"\t.long %c0\n"	\
>  			"\t.long %c1\n"	\
> -			 : : "i" (__LINE__), "i" (__FILE__))
> +			 : : "i" (__stringify(__LINE__)), "i" (__FILE__))

This part I can't agree with: changing the line number to a string 
results in excess pollution of the data segment with useless strings 
that are frequently duplicates.  Why not leave it as a number?

		-ben

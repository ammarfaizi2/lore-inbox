Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265714AbRGFBwS>; Thu, 5 Jul 2001 21:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265729AbRGFBwI>; Thu, 5 Jul 2001 21:52:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26898 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265714AbRGFBvz>; Thu, 5 Jul 2001 21:51:55 -0400
Date: Thu, 5 Jul 2001 22:51:22 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        phillips@bonn-fries.net (Daniel Phillips),
        davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Message-ID: <20010705225121.B866@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	phillips@bonn-fries.net (Daniel Phillips),
	davidel@xmailserver.org (Davide Libenzi),
	linux-kernel@vger.kernel.org
In-Reply-To: <E15II3b-0003T8-00@the-village.bc.nu> <9756.994374535@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <9756.994374535@redhat.com>; from dwmw2@infradead.org on Fri, Jul 06, 2001 at 12:08:55AM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 06, 2001 at 12:08:55AM +0100, David Woodhouse escreveu:
> 
> #define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)
> 
> #define __magic_minfoo(A,B,C,D) \
> 	({ typeof(A) C = (A); typeof(B) D = (B); C>D?D:C; })
> 
> void main(void)
> {
> 	int __var11=5, __var211=7;
> 
> 	printf("min(%d,%d) = %d (should be 11: %d)\n", __var11, __var211, min(__var11, __var211), __LINE__);
> }

Have you looked at the preprocessor output?

[acme@brinquedo /tmp]$ gcc -E a.c -o -   # or 'cpp < a.c'
# 1 "a.c"
void main(void)
{
        int __var11=5, __var211=7;

        printf("min(%d,%d) = %d (should be 11: %d)\n", __var11, __var211,
+ ({ typeof(  __var11  )   __var__LINE__  = (  __var11  ); typeof(
__var211  )   __var2__LINE__  = (   __var211  );   __var__LINE__ >
__var2__LINE__ ?  __var2__LINE__ :  __var__LINE__ ; })  , 11);
}

I didn't found a way to generate unique variable names using __LINE__

- Arnaldo

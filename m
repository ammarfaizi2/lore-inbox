Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSKZMGj>; Tue, 26 Nov 2002 07:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264654AbSKZMGj>; Tue, 26 Nov 2002 07:06:39 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:1211 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S264646AbSKZMGg>; Tue, 26 Nov 2002 07:06:36 -0500
Message-ID: <00da01c29545$40a96300$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "Folkert van Heusden" <folkert@vanheusden.com>,
       "'Ersek Laszlo'" <erseklaszlo@chello.hu>,
       <linux-kernel@vger.kernel.org>
References: <005501c294c5$d8b1e300$3640a8c0@boemboem>
Subject: Re: [PATCH] rbtree
Date: Tue, 26 Nov 2002 07:13:36 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mine produces the same code either way:
int
main()
{
   int i=0;
   if (i==0) {
       i++;
   }
}

gcc --version
2.95.3
   .file   "t1.c"
   .version    "01.01"
gcc2_compiled.:
.text
   .align 4
.globl main
   .type    main,@function
main:
   pushl %ebp
   movl %esp,%ebp
   subl $24,%esp
   movl $0,-4(%ebp)
   cmpl $0,-4(%ebp)
   jne .L3
   incl -4(%ebp)
.L3:
.L2:
   movl %ebp,%esp
   popl %ebp
   ret
.Lfe1:
   .size    main,.Lfe1-main
   .ident  "GCC: (GNU) 2.95.3 20010315 (release)"


----- Original Message ----- 
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Ersek Laszlo'" <erseklaszlo@chello.hu>; <linux-kernel@vger.kernel.org>
Sent: Monday, November 25, 2002 4:01 PM
Subject: RE: [PATCH] rbtree


> Not trying to be negative and also really wondering this: won't
> the compiler produce the same code for:
> if (!variable)
> and
> if (variable == 0)
> ?
> 
> -----Oorspronkelijk bericht-----
> Van: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]Namens Ersek Laszlo
> Verzonden: zondag 24 november 2002 23:41
> Aan: linux-kernel@vger.kernel.org
> Onderwerp: [PATCH] rbtree
> 
> 
> Hi all,
> 
> this patch tries to remove those checks for 0 from
> linux-2.4.19/lib/rbtree.c which are (I think) superfluous.
> 
> Laszlo Ersek
> 
> 
> --- linux-2.4.19/lib/rbtree.c Sat Aug  3 02:39:46 2002
> +++ linux/lib/rbtree.c Sun Nov 24 22:59:38 2002
> @@ -159,17 +159,16 @@
>   if (!other->rb_right ||
>       other->rb_right->rb_color == RB_BLACK)
>   {
> - register rb_node_t * o_left;
> - if ((o_left = other->rb_left))
> - o_left->rb_color = RB_BLACK;
> + /* unneeded check-for-0 removed */
> + other->rb_left->rb_color = RB_BLACK;
> ...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

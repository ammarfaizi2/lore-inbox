Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132452AbRBRBrr>; Sat, 17 Feb 2001 20:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRBRBrh>; Sat, 17 Feb 2001 20:47:37 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:47634 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S132452AbRBRBrZ>;
	Sat, 17 Feb 2001 20:47:25 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <andrewm@uow.edu.au>
cc: "J . A . Magallon" <jamagallon@able.es>, Hugh Dickins <hugh@veritas.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro 
In-Reply-To: Your message of "Sun, 18 Feb 2001 12:33:35 +1100."
             <3A8F266F.AFA01552@uow.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Feb 2001 12:47:17 +1100
Message-ID: <20105.982460837@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2001 12:33:35 +1100, 
Andrew Morton <andrewm@uow.edu.au> wrote:
>__BASE_FILE__ does this.  It expands to the thing which you
>typed on the `gcc' command line.
>
>bix:/home/morton> ./a.out
>3 at a.c
>3 at a.c

But __LINE__ is wrong.  Forget what I said about __C_FILE__ and
__C_LINE__, __C_LINE__ would not work for inline functions.  Looks like
the best option is a combination of __BASE_FILE__ and function name.

a.h
#define BUG() \
  printf("kernel BUG in func %s, file %s\n",__FUNCTION__,__BASE_FILE__);

static inline void hello(void)
{
  BUG();
}

a.c
#include <stdio.h>
#include <a.h>

int main()
{
    hello();
    hello();
    return 0;
}

# gcc -I`pwd` `pwd`/a.c -o a
# ./a
kernel BUG in func hello, file /home/kaos/a.c
kernel BUG in func hello, file /home/kaos/a.c


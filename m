Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRBRBYw>; Sat, 17 Feb 2001 20:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132406AbRBRBYm>; Sat, 17 Feb 2001 20:24:42 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:32988 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132399AbRBRBY2>; Sat, 17 Feb 2001 20:24:28 -0500
Message-ID: <3A8F266F.AFA01552@uow.edu.au>
Date: Sun, 18 Feb 2001 12:33:35 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "J . A . Magallon" <jamagallon@able.es>, Hugh Dickins <hugh@veritas.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
In-Reply-To: Your message of "Sun, 18 Feb 2001 01:33:53 BST."
	             <20010218013353.A1331@werewolf.able.es> <19480.982457293@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> But ....
> 
> a.h
> static inline void hello(void) { printf("%d at %s\n",__LINE__,__FILE__); }
> 
> a.c
> #include <stdio.h>
> #include "a.h"
> 
> int main()
> {
>     hello();
>     hello();
>     return 0;
> }
> 
> # ./a
> 1 at a.h
> 1 at a.h
> 

__BASE_FILE__ does this.  It expands to the thing which you
typed on the `gcc' command line.

bix:/home/morton> cat a.h
static inline void hello(void)
{
        printf("%d at %s\n",__LINE__,__BASE_FILE__);
}
bix:/home/morton> cat a.c
#include <stdio.h>
#include "a.h"

int main()
{
        hello();
        hello();
        return 0;
}

bix:/home/morton> gcc -O a.c
bix:/home/morton> ./a.out
3 at a.c
3 at a.c

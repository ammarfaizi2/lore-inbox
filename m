Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131228AbRBRAsk>; Sat, 17 Feb 2001 19:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132165AbRBRAsb>; Sat, 17 Feb 2001 19:48:31 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:28690 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131228AbRBRAsT>;
	Sat, 17 Feb 2001 19:48:19 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Hugh Dickins <hugh@veritas.com>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro 
In-Reply-To: Your message of "Sun, 18 Feb 2001 01:33:53 BST."
             <20010218013353.A1331@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 18 Feb 2001 11:48:13 +1100
Message-ID: <19480.982457293@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2001 01:33:53 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>Try this:
>a.h:
>#define hello printf("%d at %s\n",__LINE__,__FILE__)
>
>a.c:
>#include <stdio.h>
>#include "a.h"
>
>int main()
>{
>    hello;
>    hello;
>    return 0;
>}
>
>werewolf:~/ko> gcc a.c -o a
>werewolf:~/ko> a
>6 at a.c
>7 at a.c


But ....

a.h
static inline void hello(void) { printf("%d at %s\n",__LINE__,__FILE__); }

a.c
#include <stdio.h>
#include "a.h"

int main()
{
    hello();
    hello();
    return 0;
}

# ./a
1 at a.h
1 at a.h

Most uses of BUG() in headers use inline functions instead of #define.
48 occurrences of BUG() in include/{linux,asm-i386}, only 2 are in
#define.

>As I said before, my choose would be the __func__ + __LINE__ predefined macros.
>I would prefer to see 'bug in my_buggy_device_init(), line 42'. And you can
>even drop the __LINE__ part.

Function names are not unique, especially when you get into modules.


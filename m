Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132179AbRBRAeR>; Sat, 17 Feb 2001 19:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132241AbRBRAeI>; Sat, 17 Feb 2001 19:34:08 -0500
Received: from jalon.able.es ([212.97.163.2]:4327 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132179AbRBRAeB>;
	Sat, 17 Feb 2001 19:34:01 -0500
Date: Sun, 18 Feb 2001 01:33:53 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
Message-ID: <20010218013353.A1331@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0102171200530.2029-100000@localhost.localdomain> <18856.982454476@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <18856.982454476@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Feb 18, 2001 at 01:01:16 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.18 Keith Owens wrote:
> 
> __C_FILE__ and __C_LINE__ refer to the .c or .s file that included the
> header, so you get the exact location of the failing code instead of
> the name and line number of a common header which is used all over the
> place.  __C_FILE__ would be replaced with the minimum string required

Are you sure about that ?
Try this:
a.h:
#define hello printf("%d at %s\n",__LINE__,__FILE__)

a.c:
#include <stdio.h>
#include "a.h"

int main()
{
    hello;
    hello;
    return 0;
}

werewolf:~/ko> gcc a.c -o a
werewolf:~/ko> a
6 at a.c
7 at a.c

(line changes, and name is .c)
because __FILE__ and __LINE__ are expanded with respect to the current
SOURCE file (see info cpp), not header file.

As I said before, my choose would be the __func__ + __LINE__ predefined macros.
I would prefer to see 'bug in my_buggy_device_init(), line 42'. And you can
even drop the __LINE__ part.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac17 #1 SMP Sat Feb 17 01:47:56 CET 2001 i686


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136531AbREDWIY>; Fri, 4 May 2001 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136536AbREDWIP>; Fri, 4 May 2001 18:08:15 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:23173 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S136532AbREDWH6>;
	Fri, 4 May 2001 18:07:58 -0400
Date: Sat, 5 May 2001 00:07:34 +0200
From: David Weinehall <tao@acc.umu.se>
To: Christopher Kanaan <kanaan@stanford.edu>
Cc: kraxel@goldbach.in-berlin.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] sis_main.c
Message-ID: <20010505000734.A17320@khan.acc.umu.se>
In-Reply-To: <3AF2C3B3.8C668467@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3AF2C3B3.8C668467@stanford.edu>; from kanaan@stanford.edu on Fri, May 04, 2001 at 07:58:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2001 at 07:58:59AM -0700, Christopher Kanaan wrote:
> Hello, 
> I am a working with Dawson Englers meta compilation group at Stanford. 
> Here is a patch for sis_main.c  Basically the patch checks to see 
> if kmalloc returns null.  This patch applies to kernel version 2.4.4

Great, but why not follow Documentation/CodingStyle, and the example set
by the rest of the file?!

Instead of:

> --- /usr/src/linux/drivers/video/sis/sis_main.c Fri Feb  9 11:30:23 2001
> +++ ./sis_main.c        Fri May  4 07:34:47 2001
> @@ -1030,6 +1030,11 @@
>         if (heap.pohFreeList == NULL) {
>                 poha = kmalloc(OH_ALLOC_SIZE, GFP_KERNEL);
>  
> +               if(!poha)
> +                 {
> +                   return(NULL);
> +                 }
> +
>                 poha->pohaNext = heap.pohaChain;
>                 heap.pohaChain = poha;

Something like this:

        if (heap.pohFreeList == NULL) {
                poha = kmalloc(OH_ALLOC_SIZE, GFP_KERNEL);
 
+               if (!poha) {
+               	return(NULL);
+               }
+
                poha->pohaNext = heap.pohaChain;
                heap.pohaChain = poha;



/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271233AbTG2E2e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 00:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271236AbTG2E2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 00:28:34 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:60568 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S271233AbTG2E2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 00:28:22 -0400
Date: Tue, 29 Jul 2003 10:32:41 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: nagendra_tomar@adaptec.com
To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
cc: Tung-Han Hsieh <thhsieh@xcin.phys.ntu.edu.tw>,
       <linux-kernel@vger.kernel.org>, <jamagallon@able.es>
Subject: Re: malloc problem to allocate very large blocks
In-Reply-To: <Pine.LNX.4.44.0307291027230.17227-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0307291032180.17227-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I missed the system details, you already have >2GB virtual memory.

--tomar
On Tue, 29 Jul 2003, Tomar, Nagendra wrote:

> AFAIK malloc will not return you memory more than the total virtual
> memory 
> (RAM+swap) in the system. So if you want more than 2GB allocations from 
> malloc, make sure you have at least 2GB virtual mem, keeping aside some 
> space for the kernel.
> 
> --tomar
> 
> On Mon, 28 Jul 2003, Tung-Han Hsieh wrote:
> 
> > Hello,
> > 
> > I am developing applications which requires more than 2GB memory.
> > But I found that in my Linux system the malloc() cannot allocate
> > more than 2GB memory. Here is the details of my system:
> > 
> > CPU:    Pentium 4 2.53 GHz
> > RAM:    2 GB
> > Swap:   512 MB
> > OS:	Debian-3.0 stable
> > Kernel: 2.4.20
> > gcc:	2.95.4 20011002
> > glibc:  2.2.5-6
> > 
> > In theory, in a 32-bits machine the maximum allocatable memory
> > is up to 4GB. But in the following very simple testing program:
> > 
> > =====================================================================
> > #include <stdio.h>
> > #include <stdlib.h>
> > 
> > main()
> > {
> >     size_t l;
> >     char *s1=NULL, *s2=NULL;
> > 
> >     l = 1024*1024*1024;
> > 
> >     s1 = malloc(l);
> >     s2 = malloc(l);
> >     if (! s1) printf("s1 malloc failed\n");
> >     if (! s2) printf("s2 malloc failed\n");
> > }
> > =====================================================================
> > 
> > only the block for s1 can be allocated. Further, if I change the
> > program to
> > 
> > =====================================================================
> > #include <stdio.h>
> > #include <stdlib.h>
> > 
> > main()
> > {
> >     size_t l;
> >     char *s1=NULL;
> > 
> >     l = 2*1024*1024*1024;
> > 
> >     s1 = malloc(l);
> >     if (! s1) printf("s1 malloc failed\n");
> > }
> > =====================================================================
> > 
> > the gcc complier complain to me that "foo.c:9: warning: integer
> overflow
> > in expression" during the compilation (I use: "gcc foo.c" to compile
> > it),
> > and the block for s1 cannot be allocated at all. I am wondering if
> there
> > is any way to overcome the 2GB limit.
> > 
> > Thank you very much for your reply in advance.
> > 
> > 
> > Best Regards,
> > 
> > T.H.Hsieh
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


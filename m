Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUJYJQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUJYJQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 05:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUJYJQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 05:16:00 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:14311 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261727AbUJYJPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 05:15:34 -0400
Message-ID: <1098695733.417cc43516b8c@imp2-q.free.fr>
Date: Mon, 25 Oct 2004 11:15:33 +0200
From: remi.colinet@free.fr
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       suparna bhattacharya <suparna@in.ibm.com>,
       vara prasad <varap@us.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>
Subject: Re: 2.6.9-mm1 : compile error & question
References: <417C2619.7060808@free.fr> <1098688622.2563.16.camel@2fwv946.in.ibm.com>
In-Reply-To: <1098688622.2563.16.camel@2fwv946.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 192.85.50.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Vivek Goyal <vgoyal@in.ibm.com>:

> Hi Remi,
>
> On Mon, 2004-10-25 at 03:30, Remi Colinet wrote:
>
> > Sections:
> > Idx Name          Size      VMA       LMA       File off  Algn
> >  0 .text         0037d80e  c0100000  00100000  00001000  2**12
> > <-- something wrong here for LMA used to be 0xc010 000
>
>
> This has been changed so that LMA (Load memory address) reflects the
> physical address where sections shall be loaded. This is required to
> make sure that a kexec boot can load a vmlinux image.

Does it mean that the .text LMA start address is going to be definitively 0010
0000, even for those who disable kexec in their .config file?

>
>
>
> >                  CONTENTS, ALLOC, LOAD, DATA
> > 26 .bss          0006dfa0  c06c6000  c06c6000  005c7000  2**12     <--
> > somthing wrong with LMA for .bss.
> >                  CONTENTS, ALLOC, LOAD, DATA
> > 27 .comment      0000c36f  00000000  00000000  00634fa0  2**0
> >                  CONTENTS, READONLY
> > 28 .debug_line   0021497b  00000000  00000000  0064130f  2**0
> > ...
> >
> > This is very strange. The .text LMA of the vmlinux file is at 0x__0__010
> > 0000 whereas, it used to be at  0x__c__010 0000.  But then, the .bss LMA
> > of the vmlinux file suddenly jump at 0x__c__06c 6000 instead of
> > 0x__0__06c 6000 which would have seemed more natural -0).  What can
> > cause this offset? I have look for the .bss section content. It contains
> > .bss data and .bss.page_aligned. The later seems to be the root of the
> > .bss LMA offset.  .bss.page_aligned contains then empty_zero_page and
> > the  swapper_pg_dir.
>
> This looks like a problem with the older binutils package. I had faced
> similar problem on one of the machines but it was resolved as soon as I
> switched to a newer binutils package.

My distro is effectively becoming old (FC1). Going to upgrade it.

Thanks
Remi



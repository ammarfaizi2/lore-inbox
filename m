Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUFUFrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUFUFrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 01:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUFUFrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 01:47:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266124AbUFUFrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 01:47:15 -0400
Date: Mon, 21 Jun 2004 01:29:21 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: "R. J. Wysocki" <rjwysocki@sisk.pl>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Opteron bug
Message-ID: <20040621052921.GC21264@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200406192229.14296.rjwysocki@sisk.pl> <200406201347.17967.rjwysocki@sisk.pl> <20040620120247.GA21264@devserv.devel.redhat.com> <200406210254.53124.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406210254.53124.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 02:54:53AM +0300, Denis Vlasenko wrote:
> On Sunday 20 June 2004 15:02, Jakub Jelinek wrote:
> > On Sun, Jun 20, 2004 at 01:47:17PM +0200, R. J. Wysocki wrote:
> > > Well, is there any case in which the gcc can produce such stuff?
> >
> > GCC doesn't ever generate std instruction (only cld), though users
> > can use it in inline assembly or assembly source file.
> > AFAIK x86_64 glibc doesn't use it at all either.
> 
> glibc-2.3/sysdeps/i386/memcopy.h:
> 
> #define BYTE_COPY_BWD(dst_ep, src_ep, nbytes)                                 \
>   do                                                                          \
>     {                                                                         \
>       int __d0;                                                               \
>       asm volatile(/* Set the direction flag, so copying goes backwards.  */  \
>                    "std\n"                                                    \
>                    /* Copy bytes.  */                                         \
>                    "rep\n"                                                    \
>                    "movsb\n"                                                  \
>                    /* Clear the dir flag.  Convention says it should be 0. */ \
>                    "cld" :                                                    \
>                    "=D" (dst_ep), "=S" (src_ep), "=c" (__d0) :                \
>                    "0" (dst_ep - 1), "1" (src_ep - 1), "2" (nbytes) :         \
>                    "memory");                                                 \
>       dst_ep += 1;                                                            \
>       src_ep += 1;                                                            \
>     } while (0)
> 
> WORD_COPY_BWD also does this

I know, but I said x86_64 glibc, which doesn't do this.

	Jakub

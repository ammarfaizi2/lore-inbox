Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289457AbSAJOPE>; Thu, 10 Jan 2002 09:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289461AbSAJOOy>; Thu, 10 Jan 2002 09:14:54 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:58606 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289457AbSAJOOi>; Thu, 10 Jan 2002 09:14:38 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <25006.1010627525@kao2.melbourne.sgi.com> 
In-Reply-To: <25006.1010627525@kao2.melbourne.sgi.com> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Jan 2002 14:13:58 +0000
Message-ID: <25702.1010672038@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  I am assuming that you can satisfy hpa's concerns about using a
> single version of zlib for everybody.  Also note that arch/ppc/boot/
> lib has its own version of zlib which is quite different to the
> others.  First make sure that you can build one version of zlib that
> works for everybody. 

I can confirm that the JFFS2 and PPP zlib are compatible - differing in 
cosmetics only. Moving it to lib/zlib would be a good thing.

We can verify compatibility for other zlib users as an when those other
users are converted to use lib/zlib instead of their own private copy.


> The best option is to build zlib.o for the kernel (not module) and
> store it in lib.a.  Compile zlib.o if any consumer of zlib has been
> selected and add a dummy reference to zlib code in vmlinux to ensure
> that zlib is pulled from the archive if anybody needs it, even if all
> the consumers are in modules. 

AUIU you've since decided this isn't necessary - which is good. Making the
static kernel image differ according to which modules happened to be
compiled at the time is not a good thing. Sometimes we do it, but we should
avoid it when we can.

If zlib.o is used in modules only, compile it as a module. Don't put it 
into the kernel.

--
dwmw2



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965296AbWJ2Q6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbWJ2Q6A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 11:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWJ2Q6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 11:58:00 -0500
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:53906 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965296AbWJ2Q57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 11:57:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=g8gX9GwKoMSxtofSD+qMwvkjsVuFGkkF6oEbZT3VAxTiATpiCOxX0DCTd85cuHVRkNoSKNc4zz53HPKlUtcyoRJsI6gzN9ZF46M6p7dCiJegscUSivd70fz2zXkodQicLZAgiB/EE05Dwayq6FOtfPd/E9hPPcLGzkKkKIB2URU=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Mitch <Mitch@0bits.com>, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Date: Sun, 29 Oct 2006 18:57:58 +0100
User-Agent: KMail/1.9.5
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi
References: <45433D3E.3070109@0Bits.COM>
In-Reply-To: <45433D3E.3070109@0Bits.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610291857.58707.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2006 13:21, Mitch wrote:
> Hi Jeff, all,
>
> Sorry for the dealy but i've been out of the country.
>
> Anyhow i did some investigation and i've figured out the bug.
>
> Essentially if you try to compile a UML kernel on a 2.6.18.1 or above
> *host* kernel

> it will fail with the error messages shown (essentially 
> offsetof macro undefined) because between 2.6.18 and 2.6.18.1 that macro
> in /usr/include/linux/stddef.h is now wrapped in a #ifdef __KERNEL__ .
> However since UML doesn't build it's sources with that defined we get an
> undefined macro and a build failure.

Ok, we have one bug and one mistake on your part:
1) we should include <stddef.h> instead of <linux/stddef.h> in files using 
host headers (I don't have the error message at hand, so please handle this 
yourself, Jeff)
2) /usr/include/{linux,asm} being symlinks inside /usr/src/linux/include is an 
unsupported configuration since ages. #1 is still a valid bug because when a 
distribution will distribute glibc and kernheaders based on 2.6.18.1+/2.6.19 
ones we'll break anyway.

> So i'm partly right and partly wrong in my statement below. Yes i did
> compile a guest UML kernel 2.6.18 fine on host kernel of 2.6.18, and i
> believe i will be able to compile 2.6.18.1 and above also on a host
> kernel of 2.6.18 but if i change my host kernel to 2.6.18.1 or above all
> UML guest builds will fail.
>
> Can someone confirm they can build guest UML kernels on a host kernel >=
> 2.6.18.1 ??
>
> Thanks
> M

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

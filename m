Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSCGA2N>; Wed, 6 Mar 2002 19:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288830AbSCGA2E>; Wed, 6 Mar 2002 19:28:04 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:62987 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S288914AbSCGA1o> convert rfc822-to-8bit;
	Wed, 6 Mar 2002 19:27:44 -0500
Message-Id: <200203070028.TAA05389@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com (H. Peter Anvin),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 21:27:41 GMT."
             <6920.1015450061@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Wed, 06 Mar 2002 19:28:52 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dwmw2@infradead.org said:
>        MADV_DONTNEED
>               Do  not expect access in the near future.  (For the
>               time being, the application is  finished  with  the
>               given range, so the kernel can free resources asso­
>               ciated with it.)
> It's not clear from that that the host kernel is actually permitted to
> discard the data. 

Hmmm, you have better man pages than me.  I don't have an madvise man page
on either of my boxes (RH 6.2 and 7.2 :-)

>From that description, you're right.  The code is very clear on what happens,
as is the comment above sys_madvise:

 *  MADV_DONTNEED - the application is finished with the given range,
 *		so the kernel can free resources associated with it.

> UML might want that kind of thing for its (clean) page cache pages or
> something, but for pages allocated for kernel stack and task struct we
>  really want the opposite -- we want to make sure they're present when
> we  allocate them, and explicitly discard them when we're done. 

Yeah, that's a decent idea.  If you were going to make it fancier, you could
cover the case that the UML's clean pages are all busy but it has lots of
old dirty pages lying around.  But then you'd need some way for the host to
tell the UML that I/O would be a really bad idea and it should just dump
clean pages.

				Jeff


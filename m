Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752556AbWKAXXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbWKAXXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbWKAXXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:23:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:30769 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752556AbWKAXXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:23:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HVSPlhQXXrjvmplhrmLm1z8dC+Eru+lrMP+//VXzykGKRG/cG/LmqnVo6BeG196TFSr13w7VN2eHZU7eZBHA6VBlbpJxm9b7dZephj7ZLAWoea0zTE5pU+Rvn1paVo2ljeu/lQ+PuADmK4VRM7cgIW4BGtjOA4Sr7sJvzUbUE7M=
Message-ID: <9a8748490611011523i7ebc61eev2d0a66ee565ca14c@mail.gmail.com>
Date: Thu, 2 Nov 2006 00:23:09 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH] bail out in mathemu if __copy_to_user fails
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       billm@suburbia.net
In-Reply-To: <20061101151452.0a1f3a96.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611020003.16424.jesper.juhl@gmail.com>
	 <20061101151452.0a1f3a96.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Thu, 2 Nov 2006 00:03:16 +0100 Jesper Juhl wrote:
>
> > I believe we should check the return value of
> > __copy_to_user in math-emu/fpu_entry.c and bail out of save_i387_soft() if
> > it fails.
> > This patch does that.
> >
> > This also kills the warning :
> >   arch/i386/math-emu/fpu_entry.c:745: warning: ignoring return value of `__copy_to_user', declared with attribute warn_unused_result
>
>
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc4/2.6.19-rc4-mm1/broken-out/x86_64-mm-i386-mathemu-must-check.patch
>

Ohh. I was not aware of that patch. Let's apply yours, it's so much
more thorough than mine :-)

Thank you for pointing it out.

>
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> > diff --git a/arch/i386/math-emu/fpu_entry.c b/arch/i386/math-emu/fpu_entry.c
> > index d93f16e..ddf8fa3 100644
> > --- a/arch/i386/math-emu/fpu_entry.c
> > +++ b/arch/i386/math-emu/fpu_entry.c
> > @@ -742,7 +742,8 @@ #ifdef PECULIAR_486
> >    S387->fcs &= ~0xf8000000;
> >    S387->fos |= 0xffff0000;
> >  #endif /* PECULIAR_486 */
> > -  __copy_to_user(d, &S387->cwd, 7*4);
> > +  if (__copy_to_user(d, &S387->cwd, 7*4))
> > +    return -1;
> >    RE_ENTRANT_CHECK_ON;
> >
> >    d += 7*4;
>
>
> ---
> ~Randy
>


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

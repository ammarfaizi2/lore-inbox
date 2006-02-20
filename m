Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWBTF5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWBTF5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 00:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWBTF5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 00:57:17 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:56784 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932641AbWBTF5Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 00:57:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WXcrnWLuDgf8MLL0JQrIe0IJOoU0XGHPe7DKQLGFGsoMVRpxF9pdHhuVw4luT84Emckw7iSZaUDIZyhFCRpHENqg7QAxpVJaVDsWXms4E7wNzdihcPjha89r2LLhqSmUAWGk5FtuPLMPQxDu5ZBSfx4lFec4KJU/iEeSGmkyEhE=
Message-ID: <489ecd0c0602192157o72d9ba94r1751822dd65abcc3@mail.gmail.com>
Date: Mon, 20 Feb 2006 13:57:15 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Fix undefined symbols for nommu architecture
Cc: linux-kernel@vger.kernel.org, "David Howells" <dhowells@redhat.com>
In-Reply-To: <20060219214244.03147dba.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0602192024o2a136ddera294876ea8fd44a5@mail.gmail.com>
	 <20060219214244.03147dba.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Andrew Morton <akpm@osdl.org> wrote:
> "Luke Yang" <luke.adi@gmail.com> wrote:
> >
> > Hi,
> >
> >   This is a patch to add or export some undefined symbols in nommu
> > architectures (mm/nommu.c).  Based on latest mm-tree. Following
> > symbols are added: vmap, vunmap, randomize_va_space.
> >
> > Signed-off-by: Luke Yang <luke.adi@gmail.com>
> >
> > Index: git/linux-2.6/mm/nommu.c
> > ===================================================================
> > --- git.orig/linux-2.6/mm/nommu.c     2006-02-17 17:40:34.000000000 +0800
> > +++ git/linux-2.6/mm/nommu.c  2006-02-20 12:09:32.000000000 +0800
> > @@ -57,7 +57,10 @@
> >  EXPORT_SYMBOL(vfree);
> >  EXPORT_SYMBOL(vmalloc_to_page);
> >  EXPORT_SYMBOL(vmalloc_32);
> > +EXPORT_SYMBOL(vmap);
> > +EXPORT_SYMBOL(vunmap);
>
> OK.
>
> > +int randomize_va_space = 0;
>
> Not so sure about this one.  Does randomize_va_space actually make sense in
> a nommu environment?  I guess we could load relocatable binaries into a
> randomised place, but I'm not sure that this is implemented?
  No, it doesn't make sense now.  NOMMU architectures don't really use
it. I put it here just to avoid "undefined symbol" error.
>
> If no, then it would make more sense to do
>
>         #define randomize_va_space 0
  Yes, this is much better.  Do I need to resend a new patch?
>
> for nommu, so the relevant code gets thrown away by the compiler.
>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com

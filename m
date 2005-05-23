Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVEWRkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVEWRkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 13:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVEWRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 13:40:10 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:44986 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261932AbVEWRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 13:34:26 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
Date: Mon, 23 May 2005 19:36:00 +0200
User-Agent: KMail/1.7.2
Cc: Miklos Szeredi <miklos@szeredi.hu>, eric.begot@gmail.com,
       jdike@addtoit.com, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org> <200505231609.48425.blaisorblade@yahoo.it> <E1DaDj3-0002Xf-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DaDj3-0002Xf-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505231936.01102.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 May 2005 16:16, Miklos Szeredi wrote:
> > > Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for
> > > uml. At the compilation of init/main.c, it complains because it doens't
> > > find the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
> >
> > Why deleting FIXADDR_START? Also FIXADDR_USER_* are defined, just in a
> > different way (and the patch below is IIRC uncorrect).
>
> I've seen this error too after 'make menuconfig ARCH=um' on a clean
> tree.
>
> The following fixes it:
>
>   cp .config /tmp
>   make mrproper ARCH=um
>   cp /tmp/.config .
>   make ARCH=um
>
> So there's definitely something wrong with the build on UML.
Yes, an empty include/asm-um/elf.h which is not by default replaced by a 
symlink. Sadly a patch which should have been deleted it simply emptied it 
(courtesy of quilt). So

include/asm-um/elf.h:
	$(call create_the_symlink)
(which is pseudo-code) won't create it.

As a last resort I'll force that symlink to be unconditional (I hope not 
needing this).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWCVDpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWCVDpw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 22:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWCVDpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 22:45:52 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:23838 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbWCVDpv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 22:45:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PRAVDIV8H3+xw6VaOQJJloLtKK7krjvHjFbhAqn9/Yf1JK9ZD+KiBvYFxo256Qb14MjKMNIcNO44WLwbSjDVnpkAQzLDHEzMaHfs6uo+Oq8cDVCa0DJhN6YCCElrheSz/xrqVEOTxfxiPkHMq2boBcbYZbj/dJbRliy45s2B3h8=
Message-ID: <489ecd0c0603211945m14e9656bm5daf1e62eeca56a@mail.gmail.com>
Date: Wed, 22 Mar 2006 11:45:49 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Cc: linux-kernel@vger.kernel.org, Robin.getz@analog.com
In-Reply-To: <20060321031457.69fa0892.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
	 <20060321031457.69fa0892.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Thanks for your reply. See below.

On 3/21/06, Andrew Morton <akpm@osdl.org> wrote:
> "Luke Yang" <luke.adi@gmail.com> wrote:
> >
> >    This is the Blackfin archtecture patch for kernel 2.6.16.
> >
>
> There are few practical issues we need to be concerned about with new
> architectures.
>
> - We don't want to be putting 44000 lines of new code in the kernel and
>   then have it rot.  Who will support this in the long-term?  What
>   resources are behind it?  IOW: what can you say to convince us that it
>   won't rot?
>
>   The lack of a MAINTAINERS entry doesn't inspire confidence..
   As Bernd said, Analog Device has a group maintaining linux for
Blackfin. Now I am the one who in charge of committing patches into
mainline, other developers may do the same thing later.  By
MAINTAINERS entry do you mean the linux-2.6/MAINTAINER? Or shall I
list maintainers name in the patch mail?
>
> - How widespread/popular is the blackfin?  Are many devices using it?
>   How old/mature is it?  Is it a new thing or is it near end-of-life?
  As a DSP, Blackfin has been there for years and is somewhat popular.
But as a CPU which can run Linux, we are trying to make it popular.
Anyway a 5$ chip runs Linux and can do audio/video codec is a good toy
to play with.
>
>   It's a cost/benefit thing.  It costs us to add code to the kenrel.  How
>   many people would benefit from us doing that?
   As multimedia is becoming popular in embedded world, I believe many
people would benefit from a DSP running Linux.
>
> - Are easy-to-install x86 cross-build packages available?  If not, are
>   there straightforward instructions anywhere to guide people in generating
>   a cross-build setup?
http://docs.blackfin.uclinux.org/ is a good place to find documents.
In my opinion, not many CPU has such good documents site. Even a
beginner will find it as a good linux and embedded training place.
>
>   <looks>
>
>   OK, blackfin.uclinux.org seems to have that.  Does binutils support
>   blackfin?
>
> - A lot of this code appears to come from Analog Devices, but you don't ;)
  Actually I am. Just perfer gmail than outlook web (I don't use
window$, so don't have outlook to access company mailbox).
>   We'd need to see some sort of authorisation from the original authors
>   for the inclusion of their code.  Preferably in the form of
>   Signed-off-by:s.
  For this patch it is Luke Yang, then for other drivers or patches,
it would be the maintainer. All our work(software or even hardware) is
opened, our group don't do any un-GPLed software now.
>
> >  http://blackfin.uclinux.org/frs/download.php/810/blackfin-arch.patch.tar.bz2
>
> As I said, 44kloc ;)
  Sorry for the size, again :) But I really don't want to split it,
doesn't make much sense.
>
> - Do you really need to support old_mmap()?
>
> - It would be preferable to use the generic IRQ infrastructure in kernel/irq/
  Task added. I'll make it happen.
>
> - Too much use of open-coded `volatile'.  The objective should be to have
>   zero occurrences in .c files.  And volatile sometimes creates suspicion
>   even when it's used in .h files.
  volatile is not evil :) The only and correct usage is variables that
may be modified by hardware (such as MMR) or in a irq/signal handler.
I have checked my code.  Yes some kind of warpper may look better, we
have plan to change it, I'll send you patch for this.
>
> - bug: coreb_ioctl() does copy_from_user() and down() inside spinlock.
>
> - err, coreb_ioctl() does down(&file->f_dentry->d_inode->i_sem); but
>   that's a mutex now, so I assume that's actually dead code?
    Thanks. Bug reported.  Actually that's part of the reasons we want
to get into mainline: As we keep up to latest kernel, we can get rid
of the obsolete code in time.
>
>
>

--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283917AbRLEJuW>; Wed, 5 Dec 2001 04:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283920AbRLEJuM>; Wed, 5 Dec 2001 04:50:12 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33554 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S283917AbRLEJuB>; Wed, 5 Dec 2001 04:50:01 -0500
Date: Wed, 5 Dec 2001 04:49:49 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Josh McKinney <forming@home.com>,
        linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Fwd: binutils in debian unstable is broken.
Message-ID: <20011205044949.T4087@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <3C0DB3D6.9C86B865@zip.com.au> <E16BXeV-0005Im-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BXeV-0005Im-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 05, 2001 at 08:43:39AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 08:43:39AM +0000, Alan Cox wrote:
> > The problem appears to be that the linker is now actually doing what
> > we asked it to do, so the `remove_foo' entry in that table now points
> > at a function which isn't going to be linked into the kernel.  Oh dear.
> 
> The ideal it seems would be for binutils to support passing a stub function
> to use in such cases. That would keep the kernel stuff working nicely and
> allow us to do panic("__exit code called"); if anyone actually did manage
> to call one.

In binutils? This sounds more like kernel should do it...
If all .text.exit functions were not static, it would be pretty easy to do,
but I guess they are usually static. In that case, I think it would take
about 1 day hacking an libelf program, which would rewrite all object files
which are going to be linked into vmlinux, which would add a new SHN_UND symbol to
each .symtab/.strtab (say __devexit_called) and change all relocs against
symbols in .text.exit sections to this symbol instead.
Maybe even it would take even less time, it is not that hard.

	Jakub

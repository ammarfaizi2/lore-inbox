Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279613AbRJXWCT>; Wed, 24 Oct 2001 18:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279614AbRJXWCK>; Wed, 24 Oct 2001 18:02:10 -0400
Received: from ns.hobby.nl ([212.72.224.8]:58888 "EHLO hgatenl.hobby.nl")
	by vger.kernel.org with ESMTP id <S279613AbRJXWBx>;
	Wed, 24 Oct 2001 18:01:53 -0400
Date: Wed, 24 Oct 2001 23:48:26 +0200
From: toon@vdpas.hobby.nl
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
Message-ID: <20011024234826.A19967@vdpas.hobby.nl>
In-Reply-To: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva> <200110241936.RAA04632@inter.lojasrenner.com.br> <9r73pv$8h1$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9r73pv$8h1$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 24, 2001 at 07:11:59PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 07:11:59PM +0000, Linus Torvalds wrote:
> In article <200110241936.RAA04632@inter.lojasrenner.com.br>,
> Andre Margis  <andre@sam.com.br> wrote:
> >
> >Without use the tmpfs, appears to be OK!!!!!!!!!!
> 
> Ok, the problem appears to be that tmpfs stuff just stays on the
> inactive list, and because it cannot be written out it eventually
> totally clogs the system.
> 
> Suggested fix appended (from Andrea),
> 
> 		Linus

I started out with a clean 2.4.13 source tree, applied the
activate_page patch, and compile as follows:

make dep clean bzImage
make modules modules_install

The command `make modules_install' results in the following output:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.13; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.13/kernel/fs/ramfs/ramfs.o
depmod: 	activate_page

Maybe an #include of some header file is missing somewhere?

Regards,
Toon.
-- 
 /"\                             |   Windows XP:
 \ /     ASCII RIBBON CAMPAIGN   |        "I'm sorry Dave...
  X        AGAINST HTML MAIL     |         I'm afraid I can't do that."
 / \

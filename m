Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTLXIJs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 03:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTLXIJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 03:09:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:61639 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263463AbTLXIJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 03:09:47 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16361.18888.602000.438746@laputa.namesys.com>
Date: Wed, 24 Dec 2003 11:09:44 +0300
To: Shawn <core@enodev.com>
Cc: Nuno Silva <nuno.silva@vgertech.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: reiser4 breaks vmware
In-Reply-To: <3FE8B765.6000907@vgertech.com>
References: <1072202167.8127.15.camel@localhost>
	<3FE8B765.6000907@vgertech.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva writes:
 > Hi.
 > 
 > Shawn wrote:
 > > Forgive my line-wraps, but the following (among other do_mmap_pgoff
 > > related snippets) break vmware.
 > > 
 > > Couple questions out of this:
 > > 1. Does anyone care enough to produce a patch for vmware's module?
 > > 2. What does this change accomplish for reiser4?
 > > 
 > > diff -ruN linux-2.6.0-test9/arch/i386/kernel/sys_i386.c
 > > linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c 
 > > --- linux-2.6.0-test9/arch/i386/kernel/sys_i386.c       Sat Oct 25
 > > 22:44:51 2003 
 > > +++ linux-2.6.0-test9-reiser4/arch/i386/kernel/sys_i386.c       Thu Nov
 > > 13 15:39:47 2003 
 > > @@ -56,7 +56,7 @@ 
 > >         } 
 > > 
 > >         down_write(&current->mm->mmap_sem); 
 > > -       error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff); 
 > > +       error = do_mmap_pgoff(current->mm, file, addr, len, prot, flags,
 > > pgoff); 
 > >         up_write(&current->mm->mmap_sem); 
 > > 
 > >         if (file)
 > 
 > I'd say that namesys is using UML (user-mode-linux.sf.net) to develop 
 > raiser4 (smart guys, uml rocks).
 > 
 > These are probably left overs from UML's SKAS-host patch. If I'm correct 
 > you may try to reverse the SKAS patch from that tree (the patch is 
 > located at UML's site). It won't do any harm, anyway...

Exactly. I included it into core.diff by mistake.
Revert it: http://www.namesys.com/snapshots/2003.12.23/broken-out/do_mmap2-fix.diff.patch

 > 
 > Regards,
 > Nuno Silva
 > 

Nikita.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbULaEQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbULaEQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbULaEQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:16:33 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:40614 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261816AbULaEQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:16:22 -0500
Date: Fri, 31 Dec 2004 05:16:21 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Georg C. F. Greve" <greve@fsfeurope.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
Message-ID: <20041231041621.GA14321@mail.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Georg C. F. Greve" <greve@fsfeurope.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org> <m3zmzvl9x1.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2004 at 02:23:01PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 30 Dec 2004, Georg C. F. Greve wrote:
> > 
> >  lt> Any chance that you can get a full oops, with register info?
> >  lt> Right now your errors only have the call trace, not the registers
> >  lt> or the EIP itself..
> > 
> > Yes, for the first two times, the top of the crash report scrolled off
> > the screen and I don't have a serial console handy. The third crash
> > contained the 
> > 
> >  EFLAGS: 00010002   (2.6.10)
> >  EIP is at free_block+0x45/0xd0
> >  eax: 46484849   ebx: df2b1000   ecx: df2b1050   edx: df2ab000
> >  esi: c183cd80   edi: 00000001   ebp: 00000018   esp: c188fef8
> >  ds: 007b   es: 007b   ss: 0068
> >  Process events/0 (pid: 6, threadinfo:c188e000 task=c185ca20)
> >  Stack: c183cdb8 c1858810 c1858800 00000018 c183cd80 c0141724 c183cd80 c1858810
> >         00000018 c183ccb8 c183cd80 00000002 c183cce0 c01417c6 c183cd80 c1858800
> >         00000000 c183ccb8 c183ce10 00000003 c170fc20 c183b000 c170fc24 00000000
> > 
> > header, which I think may contain what you were looking for.
> 
> Ok. This is apparently a slab cache corruption issue.
> 
> Can you compile with SLAB_DEBUG and DEBUG_PAGEALLOC turned on, since that 
> may well catch something in the act (or it may make the machine so 
> unusably slow that it's not funny - who knows..)
> 
> > Meanwhile, because of the trouble, I gave Alans patch-2.6.10-ac1 a try
> > and again put ext3 on dm-crypt on raid5, and: No crash so far despite
> > moving and removing ~100 gigabytes a couple of times on to/from the
> > partition.
> 
> Goodie. Maybe Alan already knows what it's about. Alan? Any slab 
> corruption or wild pointers that you are aware of? However:
> 
> > I did however get occasional
> > 
> >  EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #37306376: directory entry across blocks - offset=0, inode=3350155169, rec_len=11148, name_len=1
> 
> I suspect that it's more of the slab corruption thing, and Alan's patch 
> ended up moving something around subtly enough that you don't get the 
> crash, but instead get corrupted buffer heads or similar.. Your BTTV 
> issues are interesting, though.

maybe this can provide more information (let me know if
you need an ASCII version, I'll transcribe it by hand then)

http://vserver.13thfloor.at/Experimental/OOPS/kernel-first-oops.jpg

(the kernel source tree might be still available)

best,
Herbert

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

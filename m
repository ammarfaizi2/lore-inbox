Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132360AbQKKUTj>; Sat, 11 Nov 2000 15:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132416AbQKKUT3>; Sat, 11 Nov 2000 15:19:29 -0500
Received: from slc602.modem.xmission.com ([166.70.7.94]:25863 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132360AbQKKUTM>; Sat, 11 Nov 2000 15:19:12 -0500
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2000 12:35:46 -0700
In-Reply-To: Tigran Aivazian's message of "Sat, 11 Nov 2000 16:46:09 +0000 (GMT)"
Message-ID: <m1ofzmcne5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@aivazian.fsnet.co.uk> writes:

> On Sat, 11 Nov 2000, Andrea Arcangeli wrote:
> 
> > On Sat, Nov 11, 2000 at 02:51:21PM +0000, Tigran Aivazian wrote:
> > > Yes, Andrea, I know that paging is disabled at the point of loading the
> > > image but I was talking about the inability to boot (boot == complete
> > > booting, i.e. at least reach start_kernel()) a kernel with very large
> > > .data or .bss segments because of various reasons -- one of which,
> > > probably,is the inadequacy of those pg0 and pg1 page tables set up in
> > > head.S
> > 
> > Ah ok, I thought you were talking about bootloader.
> > 
> > About the initial pagetable setup on i386 port there's certainly a 3M limit on
> 
> > the size of the kernel image, but it's trivial to enlarge it.  BTW, exactly
> for
> 
> > that kernel size limit reasons in x86-64 I defined a 40Mbyte mapping where we
> > currently have a 4M mapping and that's even simpler to enlarge since they're
> 2M
> 
> > PAE like pagetables.
> > 
> > Basically as far as the kernel can get loaded in memory correctly we have
> > no problem :)
> > 
> > > (which Peter says is infinite?) or the ones on .text/.data/.bss (and what
> > > exactly are they?)? See my question now?
> > 
> > We sure hit the 3M limit on the .bss clearing right now.
> > 

With respect to .bss issues we should clear it before we set up page tables.
That way we have no hardlimit short of 4GB which.

We also do stupid things like set segment registers before setting up
a GDT.  Yes we set them in setup.S but it is still a stupid non-obvious
dependency.  We we can do it in setup.S

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

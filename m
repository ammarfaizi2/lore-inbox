Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271873AbRIDBiv>; Mon, 3 Sep 2001 21:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271876AbRIDBij>; Mon, 3 Sep 2001 21:38:39 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:36613 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S271873AbRIDBi2>;
	Mon, 3 Sep 2001 21:38:28 -0400
Date: Mon, 3 Sep 2001 21:38:36 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Cc: thunder7@xs4all.nl, parisc-linux@lists.parisc-linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010903213835.A13887@fury.csh.rit.edu>
In-Reply-To: <20010902105538.A15344@middle.of.nowhere> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk> <20010902195717.A21209@middle.of.nowhere> <20010903003437.A385@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010903003437.A385@linux-m68k.org>; from Richard.Zidlicky@stud.informatik.uni-erlangen.de on Mon, Sep 03, 2001 at 12:34:37AM +0200
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 12:34:37AM +0200, Richard Zidlicky wrote:
> On Sun, Sep 02, 2001 at 07:57:17PM +0200, thunder7@xs4all.nl wrote:
> > 
> > --- linux/include/linux/reiserfs_fs.h   Sun Sep  2 21:54:25 2001
> > +++ linux-new/include/linux/reiserfs_fs.h       Sun Sep  2 20:47:27 2001
> > @@ -924,7 +924,7 @@
> >  #define DEH_Visible 2
> > 
> >  /* 64 bit systems (and the S/390) need to be aligned explicitly -jdm */
> > -#if BITS_PER_LONG == 64 || defined(__s390__)
> > +#if BITS_PER_LONG == 64 || defined(__s390__) || defined(__hppa__)
> >  #   define ADDR_UNALIGNED_BITS  (3)
> >  #endif
> 
> couldn't reiserfs use asm/unaligned.h like anyone else?
> Seems at least sparc and mips may need the same treatment.

    I'll be the first to admit that having the #if followed by arch defines
    really sucks, and that asm/unaligned.h would be much cleaner if for no
    other reason than avoiding an unnecessary gotcha for someone porting a new
    arch.

    Unfortunately, this doesn't appear to work in all cases. I know from
    testing that the S/390 case will fail using the {get,put)_unaligned macros,
    since they are identical to a normal, unassisted assignment.

    I did kick around the idea of making those macros the default accessors for
    the deh_state member (which is the only place they're used), but it unfairly
    penalizes arches that don't need them.

    I'm open to suggestions.

    -Jeff

-- 
Jeff Mahoney           |   "Bill Gates is a monocle and a Persian cat away
jeffm@suse.com         |    from being the villain in a James Bond movie."
jeffm@csh.rit.edu      |                   -- Dennis Miller

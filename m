Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271961AbRIDMu1>; Tue, 4 Sep 2001 08:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271963AbRIDMuR>; Tue, 4 Sep 2001 08:50:17 -0400
Received: from mcp.csh.rit.edu ([129.21.60.9]:45063 "EHLO mcp.csh.rit.edu")
	by vger.kernel.org with ESMTP id <S271961AbRIDMuI>;
	Tue, 4 Sep 2001 08:50:08 -0400
Date: Tue, 4 Sep 2001 08:50:23 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010904085023.C13887@fury.csh.rit.edu>
In-Reply-To: <20010902105538.A15344@middle.of.nowhere.suse.lists.linux.kernel> <20010902150023.U5126@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <20010902195717.A21209@middle.of.nowhere.suse.lists.linux.kernel> <20010903003437.A385@linux-m68k.org.suse.lists.linux.kernel> <20010903213835.A13887@fury.csh.rit.edu.suse.lists.linux.kernel> <oupoforxpc1.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <oupoforxpc1.fsf@pigdrop.muc.suse.de>; from ak@suse.de on Tue, Sep 04, 2001 at 11:44:30AM +0200
X-Operating-System: SunOS 5.8 (sun4u)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 11:44:30AM +0200, Andi Kleen wrote:
> Jeff Mahoney <jeffm@suse.com> writes:
> 
> 
> >     I did kick around the idea of making those macros the default accessors for
> >     the deh_state member (which is the only place they're used), but it unfairly
> >     penalizes arches that don't need them.
> 
> On archs that don't need them {get,put}_unaligned should be just normal
> assignments. They are certainly on i386.

    Sorry, I guess I wasn't clear.

    When I mentioned "make those macros the default ..", I was referring to the
    reiserfs-defined macros, not the asm/unaligned.h macros.

    In my previous message, I had mentioned that the get/put _unaligned macros
    from asm/unaligned.h don't work in all cases. Specifically, the S/390 (and
    S/390x) versions won't work with ReiserFS, since they're nothing more than
    a normal access/mutate put into a compatible macro. Through testing on the
    S/390{,x}, I found that using the reiserfs-defined unaligned macros did the
    trick. The only place these reiserfs-defined macros are used is to
    access/mutate the reiserfs_de_head->deh_state member, which contains flags
    for the on-disk directory entry representation.
 
    Are the S/390 asm/unaligned.h versions broken, or is the ReiserFS code doing
    something not planned for? It's a 16-bit member, at a 16-bit alignment
    in the structure.  The structure itself need not be aligned in any
    particular manner as it is read directly from disk, and is a packed structure.

    -Jeff

-- 
Jeff Mahoney           |   "Bill Gates is a monocle and a Persian cat away
jeffm@suse.com         |    from being the villain in a James Bond movie."
jeffm@csh.rit.edu      |                   -- Dennis Miller

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbQKKURK>; Sat, 11 Nov 2000 15:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbQKKURA>; Sat, 11 Nov 2000 15:17:00 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:40967 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132359AbQKKUQs>; Sat, 11 Nov 2000 15:16:48 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Ying Chen/Almaden/IBM" <ying@almaden.ibm.com>
Date: Sun, 12 Nov 2000 07:16:29 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14861.43293.117258.571355@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
        nfs-devel@linux.kernel.org
Subject: Re: [patch] nfsd optimizations for test10
In-Reply-To: message from Ying Chen/Almaden/IBM on Friday November 10
In-Reply-To: <OF973C73DE.C4472EDD-ON88256993.0080B320@LocalDomain>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 10, ying@almaden.ibm.com wrote:
> Hi,
> 
> I made some optimizations on racache in nfsd in test10. The idea is to
> replace with existing fixed length table for readahead cache in NFSD with a
> hash table.
> The old racache is essentially ineffective in dealing with large # of
> files, and yet eats CPU cycles in scanning the table (even though the table
> is small),
> the hash table-based is much more effective and fast. I have generated the
> patch for test10 and tested it.
> 
> (See attached file: nfshdiff)(See attached file: nfsdiff)
> 
> 
> Ying

Thanks for this.
A couple of questions and comments:

 1/ Do you have any stats showing what sort of speedup this gives -
    I'm curious.

 2/ Was there a particular reason that you didn't use the
      include/linux/list.h
    list structures for the hash and lru chains?  If not, I suggest
    that doing so would be a good idea.  It should make the code
    clearer and more in-keeping with other code in the kernel.

 3/ It is easiest for (many of) us if you just include the patch
    in-line in your email messages rather than as an attachment.   You
    can then be sure that EVERY mail reader can display it
    effectively, and Linus has said a number of times that he doesn't
    like attachments.
 3a/ If you or your mailer insists on using attachments, please make
    sure that the mime-type of the attachment is correct - text/plain,
    not applications/x-unknown.  Again, that makes it a lot easier to
    read your patch.

 4/ I doubt that this is significant enough to go in before 2.4.0-final now,
    but it probably has a reasonable chance of getting in shortly
    afterwards.

NeilBrown
knfsd maintainer.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

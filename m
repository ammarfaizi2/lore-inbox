Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRBWFpo>; Fri, 23 Feb 2001 00:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131454AbRBWFpf>; Fri, 23 Feb 2001 00:45:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:63503 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131447AbRBWFpY>; Fri, 23 Feb 2001 00:45:24 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mark Hemment <markhe@veritas.com>
Date: Fri, 23 Feb 2001 16:45:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14997.63717.372692.999011@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] nfsd + scalability
In-Reply-To: message from Mark Hemment on Thursday February 22
In-Reply-To: <14996.23434.271569.212657@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.21.0102220828220.11260-100000@alloc>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 22, markhe@veritas.com wrote:
> On Thu, 22 Feb 2001, Neil Brown wrote:
> > 
> > Certainly I would like to not hold the BKL so much, but I'm curious
> > how much effect it will really have.  Do you have any data on the
> > effect of this change?
> 
>   Depends very much on the hardware configuration, and underlying
> filesystem.
>   On an I/O bound system, obviously this has little effect.
> 
>   Using a filesystem which has a quite deep stack (CPU cycle heavy),
> this is a big win.  I've been running with this for so long that I can't
> find my original data files at the moment, but it was around +8%
> improvment in throughput for a 4-way box under SpecFS with vxfs as the
> underlying filesystem.  Less benefit for ext2 (all filesystems NFS
> exported "sync" and "no_subtree_check").  Some of the benefit came from
> the fact that there is also a volume manager sitting under the filesystem
> (more CPU cycles with the kernel lock held!).
   .... and more ....

Well, you are quite convincing.  I am keen to see if I can measure a
performance difference for ext2/raid5, but unfortuantely I don't have
any 4-way boxed (only duals).

If you progress with this can create any patches that do more
interesting things than just drop the lock (e.g. protect the export
table or the read-ahead cache properly), let me know and I will
certainly take them.  Meanwhile I will try to find time to have a look
myself.

Thanks,
NeilBrown

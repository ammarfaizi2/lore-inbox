Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264132AbRFLCdR>; Mon, 11 Jun 2001 22:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264145AbRFLCdH>; Mon, 11 Jun 2001 22:33:07 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:42505 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264132AbRFLCcv>; Mon, 11 Jun 2001 22:32:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: James Bottomley <James.Bottomley@SteelEye.com>
Date: Tue, 12 Jun 2001 12:32:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15141.32551.233748.557325@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS PANIC and FIX in 2.4
In-Reply-To: message from James Bottomley on Saturday June 9
In-Reply-To: <200106091752.NAA02515@localhost.localdomain>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday June 9, James.Bottomley@SteelEye.com wrote:
> Hi All,
> 
> I get this panic running RedHat 2.4.3-6:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
> c014b13d

....
> 
> The problem is pretty specific to 2.4.3-6 because it has code in list_del() to 
> null out the prev and next pointers (I don't know where they picked it up, but 
> its gone in 2.4.5).   However, it exposes a bug in NFS, namely that d_splice() 
> also calls list_del() on tdentry->d_child.  This shouldn't be done because it 
> makes the d_child list invalid, so any subsequent call to list_del on d_child 
> could panic.  I think the correct fix (attached below) is to change the NFS 
> list_del to list_del_init.

Yep, that looks good.  I'll forward it to Linus with a few other fixes
I have pending.

Thanks,

NeilBrown

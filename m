Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbQLUWpx>; Thu, 21 Dec 2000 17:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbQLUWpo>; Thu, 21 Dec 2000 17:45:44 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:10514 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131290AbQLUWpe>; Thu, 21 Dec 2000 17:45:34 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: John Covici <covici@ccs.covici.com>
Date: Fri, 22 Dec 2000 09:14:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14914.32991.480115.210561@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange nfs behavior in 2.2.18 and 2.4.0-test12
In-Reply-To: message from John Covici on Thursday December 21
In-Reply-To: <Pine.LNX.4.21.0012211324000.7606-100000@ccs.covici.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 21, covici@ccs.covici.com wrote:
> Hi.  I am having strange nfs problems in both my 2.x and 2.4.0-test12
> kernels.
> 
> What is happening is that when the machine boots up and exports the
> directories for nfs, it complains that
> 
> ccs2:/ invalid argument .
> 
> The exports entry is
> 
> / ccs2(rw,no_root_squash)

Is there another export entry that exports another part of the same
file system to the same client?  If so, that is your problem.
You cannot export two different directories on the same filesystem to
the same client if one is an ancestor of the other (because exporting
a directory is really exporting the directory and all descendants on
that filesystem, and so exporting a directory and a subdirectory is
effectively exporting the subdirectory twice with potentially
different flags).

NeilBrown

> 
> Now in Kernel 2.2.18, if I stop and restart the nfs daemons, all is
> OK, the invalid argument goes away, but in 2.4.0 I cannot get this to
> work at all and so I cannot mount nfs from a client on the ccs2 box.
> I am using the utilities 0.2.1-4 from the Debian distribution if that
> makes any difference.  I did an strace once on exportfs and it was
> having trouble with the call to nfsservctl which returns invalid argument.
> 
> 
> Any assistance would be appreciated.
> 
> -- 
>          John Covici
>          covici@ccs.covici.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

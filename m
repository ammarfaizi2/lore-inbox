Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267576AbRGNEyg>; Sat, 14 Jul 2001 00:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbRGNEy0>; Sat, 14 Jul 2001 00:54:26 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:7123 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267576AbRGNEyQ>; Sat, 14 Jul 2001 00:54:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: <josh@pulltheplug.com>
Date: Sat, 14 Jul 2001 14:53:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15183.53346.108312.309031@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: umask 000 bug/difference
In-Reply-To: message from josh@pulltheplug.com on Friday July 13
In-Reply-To: <Pine.LNX.4.33.0107131611520.22258-100000@shell.pulltheplug.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 13, josh@pulltheplug.com wrote:
> 
> 	The 2.4.x kernels starting with 2.4.3 (i think) have, after
> load, left a umask of 0000.

That was me. nfsd started to use "daemonize" so it shared the umask
(and rest of current->fs, and other stuff) with init, so we changed
the default umask to 0 as knfsd didn't want any umask getting in the
way.

It seems that someone at Redhat changed their init so that it set the
umask back to 0022, and this affected nfsd badly.

Linus has just accepted a patch which makes nfsd completely
independant of the umask setting, and sets the default umask back to
0022.  You should see it in 2.4.7-pre7

For more info, look for the thread in linux-kernel with
    [PATCH] Bug in NFS
in the subject.

NeilBrown

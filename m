Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRAZAdf>; Thu, 25 Jan 2001 19:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131721AbRAZAd0>; Thu, 25 Jan 2001 19:33:26 -0500
Received: from p3EE3C868.dip.t-dialin.net ([62.227.200.104]:55044 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129172AbRAZAdG> convert rfc822-to-8bit; Thu, 25 Jan 2001 19:33:06 -0500
Date: Fri, 26 Jan 2001 01:02:02 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.2.18 + VM-global + reiserfs + ext3 0.0.5e safe?
Message-ID: <20010126010202.C9075@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Short story:

it's again the reiserfs + ext3 issue. I managed to get ext3 and reiserfs
into the same tree. Is that safe to use without further patching?

Long story:

I have a heavily patched kernel (mostly drivers like I²C, dc390 and
stuff), among the patches are VM-global-7 by Andrea Arcangeli and
ReiserFS 3.5.28. After that, I merged ext3 0.0.5e, there were no
conflicts in buffer code or anything (so I assume my last ext3 merge
failed for VM-global-7, not for reiserfs). 

However, the old symbol clashes (buffer_journaled and release_journal)
remain. I used perl to rename these symbols to reiserfs_buffer_journaled
and reiserfs_release_journal in fs/reiserfs/*.c and
include/linux/fs_reiserfs.h, cleaned up the Makefile and *.h rejects
(only "bad context" because reiserfs was already there, and
prototypes). 

Now, is there any reason for concern the kernel might cause fs
corruption beyond the risk that EITHER reiserfs OR ext3 ONE BY ITSELF
infer?

The kernel patched like this compiles without relevant warnings and
boots up ok, copying from a ro-mounted ext2 to either reiserfs or ext3
does not cause obvious problems, but is there a potential for failure
that I can't see at the moment?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

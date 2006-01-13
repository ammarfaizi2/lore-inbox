Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWAMNtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWAMNtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 08:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWAMNtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 08:49:21 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:55478 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1422670AbWAMNtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 08:49:20 -0500
From: "Takashi Sato" <sho@tnes.nec.co.jp>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <viro@zeniv.linux.org.uk>,
       <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
       <trond.myklebust@fys.uio.no>
Subject: RE: [PATCH 1/3] Fix problems on multi-TB filesystem and file
Date: Fri, 13 Jan 2006 22:48:52 +0900
Message-ID: <000001c61848$19ba75c0$4168010a@bsd.tnes.nec.co.jp>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
In-Reply-To: <20060112183124.5b9b5565.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I sent following patches three weeks ago, but I got only a few
> > responses. So, I am sending them again.  Comments are always
> > welcome.
>
> Please don't send multiple patches under the same Subject:.  Please
> try to choose nice names for each email, as per
> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt, thanks.

I see, I'll care about it.

> > We made patches to fix problems that occur when handling a large
> > filesystem and a large file.  It was discussed on the mails titled
> > "stat64 for over 2TB file returned invalid st_blocks".
>
> It's best to not refer to an email thread in this manner - the
> covering description for a patch should be a self-contained standalone
> thing which contains all necessary info to understand the patch.

I'll care about it too.

> Could you remind us what problems this patch series solves?  It
> _appears_ to solve statfs reporting.  Does it fix anything else?
> There have been a couple of reports of filesystems outright failing on
> >2TB devices - does it address those problems, if so how?

This patch series fixes the following problems on 32 bits architecture.

 o  stat64 returns the lower 32 bits of blocks, although userland
    st_blocks has 64 bits, because i_blocks has only 32 bits.
    The ioctl with FIOQSIZE has the same problem.

 o  As Dave Kleikamp said, making >2TB file on JFS results in writing
    an invalid block number to disk inode.  The cause is the same as
    above too.

 o  In generic quota code dquot_transfer(), the file usage is calculated
    from i_blocks via inode_get_bytes().  If the file is over 2TB,
    the change of usage is less than expected.  The cause is the
    same as above too.

 o  As Trond Myklebust said, statfs64's entries related to blocks are
    invalid on statfs64 for a network filesystem which has more than
    2^32-1 blocks with CONFIG_LBD disabled. [PATCH 3/3]

-- Takashi Sato



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTEFCPu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTEFCPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:15:50 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18191
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262257AbTEFCPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:15:48 -0400
Date: Mon, 5 May 2003 19:28:13 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac2 NFS close-to-open question
Message-ID: <20030506022813.GB8350@matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Shantanu Goel <sgoel01@yahoo.com>, linux-kernel@vger.kernel.org
References: <20030427151201.27191.qmail@web12802.mail.yahoo.com> <shshe8k6ijs.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shshe8k6ijs.fsf@charged.uio.no>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 05:56:07PM +0200, Trond Myklebust wrote:
> >>>>> " " == Shantanu Goel <sgoel01@yahoo.com> writes:
> 
>      > if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO)) {
>      >   err =
>      > _nfs_revalidate_inode(NFS_SERVER(inode),inode);
>      >   if (err)
>      >     goto out;
>      > }
> 
>      > If we desire close-to-open consistency, and assuming my reading
>      > of the code is correct, is this a typo?
> 
> Duh... Now *that* is downright embarassing...
> Yup. Damn right...
> 
> Cheers,
>   Trond

Might that cause this too:

May  5 15:32:10 fileserver kernel: lockd: can't encode arguments: 5
May  5 15:33:08 fileserver last message repeated 18 times
May  5 15:34:07 fileserver last message repeated 27 times
May  5 15:35:07 fileserver last message repeated 23 times
May  5 15:36:08 fileserver last message repeated 10 times
May  5 15:37:09 fileserver last message repeated 22 times
May  5 15:37:34 fileserver last message repeated 9 times
May  5 17:24:47 fileserver kernel: lockd: can't encode arguments: 5
May  5 17:25:45 fileserver last message repeated 21 times

I have one system exporting a 112GB reiserfs partition and I've tested it
with two kernels:

2.4.20-rmap15e
2.4.21-rc1-rmap15g

2.4.21-rc1-rmap15g is giving the above error, and 2.4.20-rmap15e is not.
I'll leave it on 2.4.20-rmap15e for now and let you know if there are any
errors on that one too.

00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:07.2 USB Controller: Intel Corp. 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:08.0 VGA compatible controller: S3 Inc. ViRGE/DX or /GX (rev 01)
00:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)

I can include .config files too if needed.

Thanks,

Mike

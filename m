Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135948AbRAGHQb>; Sun, 7 Jan 2001 02:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135979AbRAGHQV>; Sun, 7 Jan 2001 02:16:21 -0500
Received: from slc248.modem.xmission.com ([166.70.9.248]:44553 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S135948AbRAGHQH>; Sun, 7 Jan 2001 02:16:07 -0500
To: Chris Wedgwood <cw@f00f.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010107045346.B696@metastasis.f00f.org> <E14Evjb-0001Dk-00@the-village.bc.nu> <20010107050718.C696@metastasis.f00f.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2001 00:05:07 -0700
In-Reply-To: Chris Wedgwood's message of "Sun, 7 Jan 2001 05:07:18 +1300"
Message-ID: <m1r92fj10c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:

> On Sat, Jan 06, 2001 at 03:58:20PM +0000, Alan Cox wrote:
> 
>     Ext2 handles large files almost properly. (properly on 2.2 +
>     patches) NFSv3 handles large files but might be missing the
>     O_LARGEFILE check.  I believe reiserfs went to at least 4Gig.
> 
> reiserfs 3.6.x under 2.4.x should go much higher unless i am reading
> something wrong
> 
> <pause>
> 
> yup, it does.
> 
> 
> as for NFS, I'm not sure how to pass O_LARGEFILE via the protocol and
> since NFS isn't really POSIX like anyhow decided we might as well
> just ingore it and have all sys_open calls for NFS look like
> O_LARGEFILE was specified

Umm.  No.  The object of LFS stuff is so that programs that can't
handle large files don't shoot themselves in the foot.  You don't
need to pass O_LARGEFILE over the protocol and knfsd doesn't need
to handle it.  But with out specifying O_LARGEFILE you should
be limited to 2GB on 32bit systems.

Moving some of the LFS checks into the VFS does sound good.  

When I looked at one of the BSD's a while ago, they had
a max file size in (the superblock?) and the VFS did basic
max file size checking.  And I think it handled all of the LFS
API at the VFS layer as well.  Alan these are two seperate
but related issues.

Putting the LFS checks, & max filesize checks into the VFS sounds
right for 2.4.x because it fixes lots of filesystems, with just a
couple of lines of code. 

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

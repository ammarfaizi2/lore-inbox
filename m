Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288510AbSADGxV>; Fri, 4 Jan 2002 01:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288514AbSADGxC>; Fri, 4 Jan 2002 01:53:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1037 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288512AbSADGwy>;
	Fri, 4 Jan 2002 01:52:54 -0500
Message-ID: <3C355143.8FAC281D@mandrakesoft.com>
Date: Fri, 04 Jan 2002 01:52:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, andries.brouwer@cwi.nl
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <Pine.LNX.4.33.0201031828540.1153-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 3 Jan 2002, Jeff Garzik wrote:
> >
> > reiserfs is blindly storing the kernel's kdev_t value raw to disk.
> 
> Well, it won't do that. You have to use "kdev_t_to_nr()", which (whenever
> the format of kdev_t changes) will still be identical in the low 16 bits.
> 
> Now, if somebody actually has the raw "kdev_t" in their on-disk
> structures, that's a real problem, but I don't think anybody does.
> Certainly I didn't see reiserfs do it (but it may well be missing a few
> "kdev_t_to_nr()" calls)

AFAICS it does:

include/linux/reiserfs.h:
#define sd_v1_rdev(sdp)         (le32_to_cpu((sdp)->u.sd_rdev))
#define set_sd_v1_rdev(sdp,v)   ((sdp)->u.sd_rdev = cpu_to_le32(v))

[jgarzik@rum reiserfs]$ grep v1_rdev *.c
inode.c:        rdev = sd_v1_rdev(sd);
inode.c:        set_sd_v1_rdev(sd_v1, inode->i_rdev );

In the first inode.c line shown here, it passes the value received
directly to init_special_inode.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262548AbRENWtr>; Mon, 14 May 2001 18:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbRENWtg>; Mon, 14 May 2001 18:49:36 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46089 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262548AbRENWtY>; Mon, 14 May 2001 18:49:24 -0400
Message-ID: <3B0060EF.9A3CF364@transmeta.com>
Date: Mon, 14 May 2001 15:49:19 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andreas Dilger <adilger@turbolinux.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Re: Inodes]
In-Reply-To: <Pine.GSO.4.21.0105141735001.19333-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Mon, 14 May 2001, H. Peter Anvin wrote:
> 
> > Correct.  At least at one time it used the offset of the directory entry
> > when that particular inode was last "seen" by the kernel... meaning that
> > when it finally dropped out of the inode cache, it would change inode
> > numbers.  I thought that was a reasonable (by no means perfect, though)
> > solution to a very sticky problem.
> 
> Unfortunately it wasn't a solution. Look: you open a file and rename it
> away. Now you want to create something in the old directory. Woops - can't
> use the old entry of our file, since we'll get icache conflict that way.
> So we get this lovely notion of reserved entries and there lies the
> madness. It gets especially nasty when you consider rmdir of something
> that used to be non-empty, but everything had been renamed away from it.
> And stayes open. Moreover, at every moment you need both the "original"
> location (inumber) and current one (for write_inode()). Better yet, you
> get to deal with opened files that are not renamed, but removed. Yes,
> all of that can be dealt with. The old driver didn't.
> 

True enough.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

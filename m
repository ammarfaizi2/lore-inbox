Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263286AbTCTXOs>; Thu, 20 Mar 2003 18:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263249AbTCTXOs>; Thu, 20 Mar 2003 18:14:48 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:30726 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263286AbTCTXNK>; Thu, 20 Mar 2003 18:13:10 -0500
Date: Fri, 21 Mar 2003 00:23:59 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: Joel.Becker@oracle.com, <akpm@digeo.com>,
       <andrey@eccentric.mae.cornell.edu>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: major/minor split
In-Reply-To: <UTC200303202224.h2KMOXC01107.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303210016360.5042-100000@serv>
References: <UTC200303202224.h2KMOXC01107.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Mar 2003 Andries.Brouwer@cwi.nl wrote:

> > There is a point I'd like to get clear: where should the
> > 16bit<->32bit dev_t conversion happen?
> 
> I am not sure I understand the question, but if I do
> the answer is "nowhere", there is no conversion
> (other than the lengthening that happens when one
> casts an unsigned short to an unsigned int).

Let's look at ext2:

	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
		raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));

Should the saved device number be a 16bit or a 32bit device number? Has 
the user any control over it?

> > how can software create nodes for a specific device?
> 
> You do not mean using mknod?

I mean via mknod, e.g. if the user has a major/minor number, how should it 
be converted to a dev_t number?

bye, Roman


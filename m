Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUCIPuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUCIPut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:50:49 -0500
Received: from baltazar.tecnoera.com ([200.24.224.1]:64662 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id S261496AbUCIPuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:50:46 -0500
Subject: Re: 2.6.3 + reiser + quota support
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Jan Kara <jack@suse.cz>
Cc: Damian =?iso-8859-2?Q?Wojs=B3aw?= <damian.wojslaw@eltekenergy.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040308163552.GA17574@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0403051232470.3537-100000@118.eltek>
	 <1078497744.27546.7.camel@blackbird.tecnoera.com>
	 <20040308143612.GA19628@atrey.karlin.mff.cuni.cz>
	 <1078762136.5333.25.camel@blackbird.tecnoera.com>
	 <20040308163552.GA17574@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Message-Id: <1078847334.16467.30.camel@blackbird.tecnoera.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Mar 2004 12:48:54 -0300
Content-Transfer-Encoding: 8bit
X-tecnoera-MailScanner-Information: Please contact the ISP for more information
X-tecnoera-MailScanner: Found to be clean
X-MailScanner-From: jpabuyer@tecnoera.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-08 at 13:35, Jan Kara wrote:
> > On Mon, 2004-03-08 at 11:36, Jan Kara wrote:
> > > > On Fri, 2004-03-05 at 08:33, Damian Wojs³aw wrote:
> > > > > > [root@test mnt]#
> > > > > > and /var/log/messages says:
> > > > > > Mar  4 19:15:46 test kernel: reiserfs_getopt: unknown option "usrquota"
> > > > > 
> > > > > 	If I remember correclty, reiserfs needs an additional patch to
> > > > > support quota. I know this patch exists for 2.4.X kernels.
> > > > 
> > > > Yes, patches to support quota exist for 2.4.x kernels, because 2.4.x is
> > > > not supposed to support quota for reiserfs in the vanilla distribution.
> > > > Those patches are at
> > > > ftp://ftp.suse.com/pub/people/mason/patches/reiserfs/quota-2.4
> > > > and work fine.
> > > > 
> > > > But kernel 2.6.x is supposed to support quota for ext2, ext3 _and_
> > > > reiserfs without any patch. So I am doing something wrong (I hope), or
> > > > there is a bug around here.
> > >   Actually the text in Configure is a bit misleading. In 2.6 you also
> > > need an additional patch for ReiserFS. Chris Mason created it a few days
> > > ago so it might be available at his FTP..
> > > 								Honza
> > 
> > that would be it
> > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/experimental/2.6.3
> > 
> > Thanks!
> > 
> > ps: how much should I be intimidated by that "experimental" directory
> > name?
>   Because the patch was created a few days ago it is not very widely
> tested (I mean tested in the real environment..)... That is the reason
> why it is in experimental (at least I'd guess :)).
> 
> 								Honza

Well, it didn't work. I applied patches and everything, but quota is
still non-operative for reiserfs.

[root@test mnt]# mount -o defaults,usrquota /dev/hdc1 test
mount: wrong fs type, bad option, bad superblock on /dev/hdc1,
       or too many mounted file systems
[root@test mnt]# tail -1 /var/log/messages
Mar 10 12:29:59 test kernel: reiserfs_getopt: unknown option "usrquota"
[root@test mnt]#
[root@test mnt]# uname -a
Linux test.tecnoera.com 2.6.3 #1 SMP Wed Mar 10 11:56:44 CLST 2004 i686
i686 i386 GNU/Linux
[root@test mnt]# grep -i quota /usr/src/linux-2.6.3/.config
# CONFIG_XFS_QUOTA is not set
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
[root@test mnt]#

If there is any test you want me to perform on this machine, I can do
it.




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVFNMvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVFNMvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 08:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFNMvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 08:51:39 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:1351 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S261219AbVFNMvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 08:51:31 -0400
Date: Tue, 14 Jun 2005 14:51:30 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
Message-ID: <20050614125130.GA30812@harddisk-recovery.com>
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AE1D4A.3030504@namesys.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:56:58PM -0700, Hans Reiser wrote:
> Andreas Dilger wrote:
> >Hans, it would probably be preferrable to get ext2-like behaviour where
> >action is configurable (see below),
> >
> > I personally would be annoyed if my
> >workstation rebooted if there is a read error from the disk.
> >  
> My concern is that real users don't read their logs and won't notice
> that a disk is going bad, and there is no effective method for the
> kernel notifying userspace of an error requiring user attention.

Speaking from experience (not only by profession, but also as a real
user), you figure out pretty fast something is wrong with an Ext[23]
filesystem mounted with 'errors=remount-ro'. All kind of file writes go
wrong and soon enough you figure out a hardware error is the problem.
Umount the filesystem, recover the filesystem image to a new drive,
fsck it, recover most of your data, and you're up and running again.

Reiserfs will just continue and only issues a few warning in the log,
which on its turn will not be read. Only after a few days when things
have turn worse you will figure out there's something wrong that
requires uses attention. By that time, changes are that the single disk
error (be it hardware or software) changed into multiple errors which
can make you loose quite some data.

I don't want to discredit Reiserfs or Ext[23], but filesystems are not
well tested with real disk errors. In my experience a filesystem trying
to continue to use a faulty medium usually makes things worse and
decreases the probability for a succesful recovery.

I'd rather have a filesystem which I can tell to warn me immediately
about a problem and not make things worse by trying to continue.
A mount option for Reiserfs like Andreas proposed would be a good idea.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands

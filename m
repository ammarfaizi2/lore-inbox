Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVD2XTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVD2XTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 19:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbVD2XTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 19:19:39 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:12227 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S263057AbVD2XTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 19:19:36 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
To: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 30 Apr 2005 01:18:19 +0200
References: <3YLdQ-4vS-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> wrote:

> As we try to gradually obsolete smbfs, this came up with various users
> (there was even a bugzilla bug opened for adding it) who said that they
> need the ability to unmount their own mounts for network filesystems
> without using /etc/fstab.    Unfortunately for network filesytsems,
> unlike local filesystems, it is impractical to put every possible mount
> target in /etc/fstab since servers get renamed and the universe of
> possible cifs mount targets for a user is large.
> 
> There seemed only three alternatives -
> 1) mimic the smbfs ioctl -   as can be seen from smbfs and smbumount
> source this has portability problems because apparently there is no
> guarantee that uid_t is the same size in kernel and in userspace - smbfs
> actually has two ioctls for different sizes of uid field - this seemed
> like a bad idea
> 2) export the uid in /proc/mounts - same problem as above
> 3) call into the kernel to see if current matches the uid of the mounter
> - this has no 16/32/64 bit uid portability issues since the check is
> made in kernel

4) Turn umounting own mounts into a non-privileged operation.

As (AFAI see) the only thing that needs suid privileges is the umount
operation, and it is granted if the user mounted it himself, you can as
well do this simple check in the kernel.
-- 
Funny quotes:
40. Isn't making a smoking section in a restaurant like making a peeing
    section in a swimming pool?


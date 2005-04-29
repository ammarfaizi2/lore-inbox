Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263020AbVD2VhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbVD2VhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVD2Vdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:33:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262991AbVD2VbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:31:18 -0400
Date: Fri, 29 Apr 2005 22:31:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
Message-ID: <20050429213108.GA15262@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
References: <4272A275.4030801@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4272A275.4030801@austin.rr.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:09:09PM -0500, Steve French wrote:
> > does and who revied that?  Things like that don't have a business in the
> > kernel, and certainly not as ioctl.
> 
> Other filesystems such as smbfs had an ioctl that returned the uid of 
> the mounter which they used (in the smbfs case in smbumount).  This was 
> required by the unmount helper to determine if the unmount would allow a 
> user to unmount a particular mount that they mounted.   Unlike in the 
> case of mount, for unmount  you can not use the owner uid of the mount 
> target to tell who mounted that mount.   I had not received any better 
> suggestions as to how to address it.   I had proposed various 
> alternatives - exporting in in /proc/mounts e.g.   

exporting the uid using the show_options superblock methods sounds like
a much better option.

> As we try to gradually obsolete smbfs, this came up with various users 
> (there was even a bugzilla bug opened for adding it) who said that they 
> need the ability to unmount their own mounts for network filesystems 
> without using /etc/fstab.    Unfortunately for network filesytsems, 
> unlike local filesystems, it is impractical to put every possible mount 
> target in /etc/fstab since servers get renamed and the universe of 
> possible cifs mount targets for a user is large.

Do you use the same suid wrapper hack for mounts as fuse?  Maybe you
should chime in on that thread so we can find a proper solution.

> 
> There seemed only three alternatives -
> 1) mimic the smbfs ioctl -   as can be seen from smbfs and smbumount 
> source this has portability problems because apparently there is no 
> guarantee that uid_t is the same size in kernel and in userspace - smbfs 
> actually has two ioctls for different sizes of uid field - this seemed 
> like a bad idea
> 2) export the uid in /proc/mounts - same problem as above

No.  /proc/self/mounts is an ASCII format, so there's no problem with
differemt sizes.


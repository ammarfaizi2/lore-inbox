Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUGaDeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUGaDeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 23:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267902AbUGaDeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 23:34:10 -0400
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:7387 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261682AbUGaDeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 23:34:02 -0400
Subject: Re: uid of user who mounts
From: Steve French <smfrench@austin.rr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040730190825.7a447429.rddunlap@osdl.org>
References: <1091239509.3894.11.camel@smfhome.smfdom>
	 <20040730190825.7a447429.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1091244841.2742.8.camel@smfhome1.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Fri, 30 Jul 2004 22:34:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks - I had missed that - and it is a little cleaner to call it
"user" than "mount_uid" in the line in /proc/mounts, and there are no
existing parms returned that are similar (except "username" which should
be easy enough to understand). Interestingly I did not see other
filesystems returning that in /proc/mounts (I slightly prefer having it
stored in the filesystems kernel code and returned in showopts not just
put by userspace in the file mtab) - the only minor annoyance is that /
etc/mtab returns the username (rather than the uid).


On Fri, 2004-07-30 at 19:08 -0700, Randy.Dunlap wrote:
> On Fri, 30 Jul 2004 21:05:09 -0500 Steve French wrote:
> 
> | To allow user unmounts of cifs shares (much like the setuid smbumount
> | utility allows for smbfs), it has been suggested that the cifs vfs could
> | return the uid of the mounter in /proc/mounts  This would avoid having
> | to add an ioctl (as smbfs did) and seems as secure as the ioctl approach
> | (to get the uid of the original mounter).
> | 
> | If user mounts are allowed, is there any worse security exposure in
> | letting the tool check the uid who mounted via /proc/mounts (to allow
> | user unmount).   
> | 
> | Is there any precedent for the name for the name of such a parm?  I was
> | thinking of "mnt_uid" since simply using "uid=" would seem to overload
> | the meaning of "uid", which is already used as a mount parm by various
> | filesystems to signify the default uid for files ( ie in the cifs case
> | when mounting to Windows - and Unix CIFS protocol extensions are not
> | enabled) and it is not always the case that the default uid for files
> | would be the same as the uid of the person who mounted.
> 
> For the last question, looks like "user=" is already used for that.
> See 'man mount':
> 
>               user   Allow  an  ordinary  user to mount the file system.  The
>                      name of the mounting user is written to mtab so that  he
>                      can  unmount the file system again.  This option implies
>                      the options noexec, nosuid, and nodev (unless overridden
>                      by   subsequent   options,   as   in   the  option  line
>                      user,exec,dev,suid).
> 
> 
> 
> --
> ~Randy


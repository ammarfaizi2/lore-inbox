Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267641AbUGaPVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267641AbUGaPVt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 11:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUGaPVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 11:21:49 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:1679 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S267641AbUGaPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 11:21:44 -0400
Subject: Re: uid of user who mounts
From: Steve French <smfrench@austin.rr.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu>
References: <1091239509.3894.11.camel@smfhome.smfdom>
	 <20040730190825.7a447429.rddunlap@osdl.org>
	 <1091244841.2742.8.camel@smfhome1.smfdom>
	 <E1BqqGd-0004fX-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Message-Id: <1091287308.2337.6.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 31 Jul 2004 10:21:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is an interesting patch. 

I confirmed what Randy had mantioned about the user= entries in mtab
allowing umounts (at least it works that way for a few of the local
filesystems I tried) but did not seem to work so well on other
filesystems - I had odd results on umounting my cifs mounts e.g. - after
adding at mount time "user=someuser" to /etc/mtab (by a minor change to
the mount helper mount.cifs.c, when running mount.cifs suid).  umount of
those mounts failed and has been tricky to debug through a privately
built version of umount via ddd (although it is clearly not making it
down to the cifs filesystem on the user umount so the problem is in libc
or in fs/namespace.c) - so I am tracing through fs/namespace.c now.

On Sat, 2004-07-31 at 04:35, Miklos Szeredi wrote:
> Steve French wrote:
> > 
> > Thanks - I had missed that - and it is a little cleaner to call it
> > "user" than "mount_uid" in the line in /proc/mounts, and there are no
> > existing parms returned that are similar (except "username" which should
> > be easy enough to understand). Interestingly I did not see other
> > filesystems returning that in /proc/mounts (I slightly prefer having it
> > stored in the filesystems kernel code and returned in showopts not just
> > put by userspace in the file mtab) - the only minor annoyance is that /
> > etc/mtab returns the username (rather than the uid).
> 
> I support adding 'user=UID' to the /proc/mounts output.  Actually I
> have an older patch which contains this feature.  This is slightly big
> patch which also deals with completely elliminating the need for a
> suid mount program for some specific filesystems.  See:
> 
> http://marc.theaimsgroup.com/?l=linux-fsdevel&m=108116200509753&w=2
> 
> Miklos


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUEFQhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUEFQhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEFQgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:36:09 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:49642 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261236AbUEFQfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:35:43 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16538.26969.343294.164709@laputa.namesys.com>
Date: Thu, 6 May 2004 20:35:37 +0400
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] code for raceless /sys/fs/foofs/*
In-Reply-To: <20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk>
References: <16536.61900.721224.492325@laputa.namesys.com>
	<20040505162802.GN17014@parcelfarce.linux.theplanet.co.uk>
	<20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:
 > On Wed, May 05, 2004 at 05:28:03PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
 > > On Wed, May 05, 2004 at 05:53:16PM +0400, Nikita Danilov wrote:
 > > > Hello,
 > > > 
 > > > attached patch adds code necessary to safely export per-super-block
 > > > information in /sys/fs and /proc/fs.
 > > > 
 > > > Common problem with exporting file system information in procfs or sysfs
 > > > is a race between method that inputs/outputs data and concurrent umount
 > > > of the super-block involved.
 > >  
 > > Aside of the implementation questions (will comment later), there is an
 > > interface problem here.  We end up allowing anyone who has sysfs mounted
 > > (in chroot jail, in limited namespace, etc.) to pin down _any_ reiser4
 > > superblock, whether they have the thing itself mounted or not.
 > 
 > [sorry about truncated message - -ENOCOFFEE hits]
 > 
 > We also allow anyone with sysfs mounted to see which filesystems are currently
 > mounted on the box - again, regardless of being able to see them in the
 > chroot jail/restricted namespace/etc.  It can easily become an issue in
 > setups where such information is sensitive.

But isn't this a problem with sysfs in general? Restricted process still
observes all devices, busses, etc. through /sys. If such information is
sensitive, shouldn't there be some way to selectively mount only
portions of kobject trees? For example, when file system is mounted, its
/sys/fs/foofs/sb-id tree is mounted in the same namespace. That is, we
need something like

    int sysfs_mount(struct kobject *root, char *mountpoint);


What I am concerned about is that building special foofs-meta
file-system on top of fs/libfs.c for each file-system foofs would lead
to the code duplication, while sysfs/kobjects already have all the
paraphernalia in place.

Nikita.

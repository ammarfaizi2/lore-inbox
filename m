Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbTKSOTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTKSOTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:19:42 -0500
Received: from ns.suse.de ([195.135.220.2]:41154 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264093AbTKSOTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:19:33 -0500
Date: Wed, 19 Nov 2003 15:19:30 +0100
From: Olaf Hering <olh@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is initramfs freed after kernel is booted?
Message-ID: <20031119141930.GA24228@suse.de>
References: <E1ALlQs-000769-00.arvidjaar-mail-ru@f7.mail.ru> <3FB90A6A.4050505@nortelnetworks.com> <20031117180312.GZ24159@parcelfarce.linux.theplanet.co.uk> <200311172133.59839.arvidjaar@mail.ru> <20031117191513.GA24159@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031117191513.GA24159@parcelfarce.linux.theplanet.co.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Nov 17, viro@parcelfarce.linux.theplanet.co.uk wrote:

> Alternatively, you could
> mkdir /root
> mount final root on /root
> 
> chdir("/root");
> mount("/", "initramfs", NULL, MS_BIND, NULL);

Does this bind mount really work?

static struct super_block *rootfs_get_sb(struct file_system_type *fs_type,
        int flags, const char *dev_name, void *data)
{
        return get_sb_nodev(fs_type, flags|MS_NOUSER, data, ramfs_fill_super);
}

static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
{
        if (mnt->mnt_sb->s_flags & MS_NOUSER)
                return -EINVAL;
...

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

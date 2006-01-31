Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWAaDYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWAaDYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 22:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWAaDYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 22:24:49 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:65457
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030297AbWAaDYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 22:24:48 -0500
Date: Mon, 30 Jan 2006 19:24:38 -0800
From: Greg KH <greg@kroah.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
       klibc list <klibc@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [klibc] Exporting which partitions to md-configure
Message-ID: <20060131032438.GB8920@kroah.com>
References: <43DEB4B8.5040607@zytor.com> <20060131032133.GA8920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131032133.GA8920@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 07:21:33PM -0800, Greg KH wrote:
> On Mon, Jan 30, 2006 at 04:52:08PM -0800, H. Peter Anvin wrote:
> > I'm putting the final touches on kinit, which is the user-space 
> > replacement (based on klibc) for the whole in-kernel root-mount complex. 
> >   Pretty much the one thing remaining -- other than lots of testing -- 
> > is to handle automatically mounted md devices.  In order to do that, 
> > without adding userspace versions of all the paritition code (which may 
> > be a future change, but a pretty big one) it would be good if the 
> > partition flag to auto-configure RAID was available in userspace, 
> > presumably through sysfs.
> 
> What are you looking for exactly?  udev has a great helper program,
> volume_id, that identifies any type of filesystem that Linux knows about
> (it was based on the ext2 lib code, but smaller, and much more sane, and
> works better.)
> 
> Would that help out here?

Oh, an example of it working:
	# vol_id /dev/sda3
	ID_FS_USAGE=filesystem
	ID_FS_TYPE=ext3
	ID_FS_VERSION=1.0
	ID_FS_UUID=9d2efd53-6b5a-4f84-86cc-def71269b7ca
	ID_FS_LABEL=
	ID_FS_LABEL_SAFE=
	# vol_id -t /dev/sda3
	ext3
	# vol_id -u /dev/sda3
	9d2efd53-6b5a-4f84-86cc-def71269b7ca

It also shows just the label if you have one set (I don't on this
disk...)

thanks,

greg k-h

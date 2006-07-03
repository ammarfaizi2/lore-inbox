Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWGCSXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWGCSXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 14:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGCSXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 14:23:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:65147 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932099AbWGCSXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 14:23:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a7Wcnzxl0PARxd90vMwdjV5E9TgSOWjnjjG0yuBBwrFVCwlDji4HbLIHHguNxtOoVc/xdXEVxyEnLAF/dWMrrlOPqkeCYWokIGwWHqtr7IFPIfrkxgqd4AgDg24lT12YqGO6C+EtgN1bKoojYcihIy+5B4TUmyK8L58k11/SqqM=
Message-ID: <bda6d13a0607031123p78a60f90u385be194e1623856@mail.gmail.com>
Date: Mon, 3 Jul 2006 11:23:06 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/20] honor r/w changes at do_remount() time
In-Reply-To: <20060703174804.GD29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060627221436.77CCB048@localhost.localdomain>
	 <20060627221457.04ADBF71@localhost.localdomain>
	 <20060628051935.GA29920@ftp.linux.org.uk>
	 <1151947814.11159.147.camel@localhost.localdomain>
	 <20060703174804.GD29920@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Mon, Jul 03, 2006 at 10:30:14AM -0700, Dave Hansen wrote:
> > On Wed, 2006-06-28 at 06:19 +0100, Al Viro wrote:
> > >         * make the moments when i_nlink hits 0 bump the superblock writers
> > > count; drop it when such sucker gets freed on final iput.
> >
> > Could you elaborate on this one a bit?
> >
> > I assume that there are rules that once i_nlink hits 0, it never goes
> > back up again.  It seems that a whole bunch (if not all) of the
> > individual filesystems do things to it.  Is it really necessary to go
> > into all of those looking for the places that i_nlink hits 0?  Seems
> > like it would be an awful lot of patching.

That would be a poor assumption. Somebody could do ln /proc/pid/fd/3
/mnt/newname at this point.  In my personal filesystem, there is an
ioctl that does the equivalent of link(handle, "path"). Both of these
allow the link count to rise from zero.

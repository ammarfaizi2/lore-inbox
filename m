Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTLKPDU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTLKPDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:03:20 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:40711 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265110AbTLKPDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:03:15 -0500
To: Greg KH <greg@kroah.com>
Cc: Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
Subject: Re: usbfs mount options doesn't work in 2.6, works fine with 2.4
References: <1070859138.1882.2.camel@chevrolet.hybel>
	<1070859550.2001.1.camel@chevrolet.hybel>
	<20031210213142.GB8784@kroah.com> <871xrbbedt.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 12 Dec 2003 00:03:05 +0900
In-Reply-To: <871xrbbedt.fsf@devron.myhome.or.jp>
Message-ID: <87wu939z2u.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Greg KH <greg@kroah.com> writes:
> 
> > On Mon, Dec 08, 2003 at 05:59:10AM +0100, Stian Jordet wrote:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=1418
> > > and
> > > http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0666.html
> > 
> > Yeah, it's a bug.  I haven't had the time to track it down yet.  Any
> > help with this would be greatly appreciated.
> 
> I looked driver/usb/inode.c. usbfs use get_sb_single(), but doesn't
> implement ->remount_fs(). So options can pass the only first mount.
> 
> And I guess, in this case, simple_pin_fs() in create_special_files()
> did the first mount, and simple_pin_fs() pass the usbfs_fill_super()
> to NULL.
> 
> I think ->remount_fs() helps this. But I'm not sure, sorry.

Ah, ->remount_fs() is not enough for already created inode, even if I
was right.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

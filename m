Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTKFXlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTKFXlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:41:22 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:19467 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263888AbTKFXlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:41:17 -0500
Date: Fri, 7 Nov 2003 00:41:14 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Paulo Moura Guedes <pmg@netcabo.pt>
Cc: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org
Subject: Re: test9 - USB and fat32 not working
Message-ID: <20031106234114.GA14739@win.tue.nl>
References: <200311062110.45986.pmg@netcabo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311062110.45986.pmg@netcabo.pt>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 09:10:45PM +0000, Paulo Moura Guedes wrote:

> FAT: Unrecognized mount option "owner=mojo" or missing value

>From mount(8):

       (iii) Normally, only the superuser can mount file systems.
       However, when fstab  contains the "user" option on a line,
       anybody can mount the corresponding system.

       Thus, given a line
              /dev/cdrom  /cd  iso9660  ro,user,noauto,unhide
       any user can mount the iso9660 file system  found  on  his
       CDROM using the command
              mount /dev/cdrom
       or
              mount /cd
       ...                 The owner option  is  similar  to  the
       user  option,  with  the restriction that the user must be
       the owner of the special file. This may be useful e.g. for
       /dev/fd  if a login script makes the console user owner of
       this device.

That is: the syntax is "owner", not "owner=...".
Also, this is an option handled by mount, so kernel version
should play no role.

However, 2.6 does more strict option checking, and complains
about unknown options, while 2.4 in many places just ignores them.


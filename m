Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVADLxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVADLxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVADLxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:53:36 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:47317 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261186AbVADLxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:53:30 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
To: Nicholas Miell <nmiell@comcast.net>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Reply-To: 7eggert@gmx.de
Date: Tue, 04 Jan 2005 12:57:59 +0100
References: <fa.ea9o20r.kje5qn@ifi.uio.no> <fa.lub44op.a2ec2d@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1ClnK3-0000TB-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:

> Instead of adding another ioctl, wouldn't an xattr be more appropriate?
> For instance, system.fatattrs containing a text representation of the
> attribute bits.
> 
> i.e.
> a = archive

Should be the "dump" attribute

> d = directory

It's the file type. Redundant.

> h = hidden
> r = read only

Should be reflected by the write bits. (Maybe there should be an option to
set the file mode for "read only" files to something different than
$rw_mode and not 0222.)

> s = system

Should be made "immutable", IMO

> v = volume

The volume bit of a file will never be set, since no file is a volume name.
Setting a volume attribute should be disallowed, too, since it would cause
fs corruption. This leaves us with no need to know or set 'v'.

You should rather make the volume name be similar to the e2fs volume label.

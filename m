Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVBEMks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVBEMks (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 07:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbVBEMkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 07:40:46 -0500
Received: from aun.it.uu.se ([130.238.12.36]:37527 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261606AbVBEMkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 07:40:21 -0500
Date: Sat, 5 Feb 2005 13:39:19 +0100 (MET)
Message-Id: <200502051239.j15CdJc8020766@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: agruen@suse.de
Subject: Re: ext3 extended attributes refcounting wrong?
Cc: adilger@clusterfs.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sct@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Feb 2005 17:19:09 +0100, Andreas Gruenbacher wrote:
>On Fri, 2005-02-04 at 15:15, Mikael Pettersson wrote:
>
>> Plain www.kernel.org kernels always.
>
>Good, it's no bug then. Stephen already explained what's going on: when
>a file has xattrs and you delete the file while running a kernel without
>xattr support, the xattr block's refcount is not decremented. You end up
>with a reference count that is one too high. This won't result in
>filesystem corruption, but e2fsck will fix up the refcounts for you.
>Those are the mesages you were getting.

It explains why ext3 file systems acquire inconsistencies when
people dual-boot 2.6 and 2.4. It does not explain why 2.6 allocated
the xattr blocks in the first place; as I wrote initially, I
have disabled the xattrs stuff:

CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set

/Mikael

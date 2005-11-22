Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVKVT5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVKVT5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbVKVT5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:57:14 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:20309 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S965162AbVKVT44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:56:56 -0500
Date: Tue, 22 Nov 2005 13:56:52 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122195652.GB660478@hiwaay.net>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <1132690779.20233.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132690779.20233.74.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Alan Cox <alan@lxorguk.ukuu.org.uk> said:
> It was a nice try but there is a giant gotcha most people forget. Its
> only safe to make this assumption while you have all of the
> files/directories in question open.

Tru64 adds a "st_gen" field to struct stat.  It is an unsigned int that
is a "generation" counter for a particular inode.  To get a collision
while creating and removing files, you'd have to remove and create a
file with the same inode 2^32 times while tar (or whatever) is running.
Here's what stat(2) says:

  Two structure members in <sys/stat.h> uniquely identify a file in a file
  system: st_ino, the file serial number, and st_dev, the device id for the
  directory that contains the file.

  [Tru64 UNIX]  However, in the rare case when a user application has been
  deleting open files, and a file serial number is reused, a third structure
  member in <sys/stat.h>, the file generation number, is needed to uniquely
  identify a file. This member, st_gen, is used in addition to st_ino and
  st_dev.

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.

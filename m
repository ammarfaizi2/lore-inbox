Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUCTPDK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbUCTPDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:03:10 -0500
Received: from mail-ext.curl.com ([66.228.88.132]:36616 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S263435AbUCTPDH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:03:07 -0500
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gznab4lhm.fsf@patl=users.sf.net>
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <20040320083411.GA25934@wohnheim.fh-wedel.de>
Date: 20 Mar 2004 10:03:05 -0500
In-Reply-To: <mit.lcs.mail.linux-kernel/20040320083411.GA25934@wohnheim.fh-wedel.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neat stuff!  But...

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> + * Files with the S_COWLINK flag set cannot be written to, if more
> + * than one hard link to them exists.  Ultimately, this function
> + * should copy the inode, assign the copy to the dentry and lower use
> + * count of the old inode - one day.

What happens if the disk fills while you are making the copy?  Will
open(2) on an *existing file* then return ENOSPC?

I do not think you can implement this without changing the interface
to open(2).  Which means applications have to be made aware of it
anyway.  Which means you might as well leave your implementation as-is
and let userspace worry about creating the copy (and dealing with the
resulting errors).

 - Pat

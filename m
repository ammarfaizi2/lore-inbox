Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267266AbUBSOF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267261AbUBSOF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:05:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:56218 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267268AbUBSOFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:05:18 -0500
Subject: Re: JFS default behavior / UTF-8 filenames
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: kernel@mikebell.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040219105913.GE432@tinyvaio.nome.ca>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
	 <20040219105913.GE432@tinyvaio.nome.ca>
Content-Type: text/plain
Message-Id: <1077199506.2275.12.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 08:05:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-02-19 at 04:59, kernel@mikebell.org wrote:
> For filesystems like JFS and NTFS, I think this is the best way in the
> long run, have the kernel output as UTF-8 by default, assume UTF-8
> inputs, and reject non-UTF8 filenames because they can't really store
> the arbitrary string of bytes model anyway.

Actually, I just submitted a patch to fix the default behavior of JFS to
always treat the name as an arbitrary string.  The previous default
depended on the value of CONFIG_NLS_DEFAULT.  Setting the mount option
iocharset=utf8 will reject non-utf8 filenames as you propose.

The arbitrary string of bytes is treated as the latin1 charset in that
it is stored as 0x00nn (in UTF2), but JFS really doesn't care what the
character set is.

> For others which can, maybe leave it up to the filesystem creator
> whether to reject non-UTF8 filenames or to accept invalid ones as well?

It's been said before, but a posix-compliant file system should accept
any bytes other that NUL and '/'.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center


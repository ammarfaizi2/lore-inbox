Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVALPnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVALPnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVALPnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:43:49 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:43650 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261223AbVALPns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:43:48 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] Merging?
Date: Wed, 12 Jan 2005 15:19:07 GMT
Message-ID: <050LJVV12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, there doesn't seem to be a great rush to include FUSE in the
> kernel. Maybe they just don't realize what they are missing out on ;)

Linux tree does not want zilion filesystems to be merged in, even if it's
supposed to be an open system, and the reason is that it would be a nightmare
to update all of them with each VFS, locking, etc changes.

So, FUSE is a must because it enables all these strange filesystems for special
purpose (Pliant http://pliant.cx/ can use it as an example to export part of
it's internal VFS, and nobody cares about Pliant),
to have minimal deal with Linux kernel internal details, and to not crash the
all machine in case of small problem in the strange filesystem.

The only serious objection to not using FUSE for strange filesystems is speed,
so here are some numbers:
On the test machine I found that using a native fisystem (EXT3) as the storage
backend, I can server files at 200 MB/second (using loopback as the network layer),
and using a user land over FUSE filesystem as the storage backend, I can serve
files at 50 MB/second.

If you read the second number, you discover that the speed penality is not
serious except for very demanding servers or applications, because the nowdays
disks throughoutput is also rougly 50 MB/second.
So in my test, if I had not done the test on a small 100 MB file already loaded
in the Linux cache, the effective speed would have been roughly the same.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWCGFXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWCGFXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCGFXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:23:20 -0500
Received: from mxsf42.cluster1.charter.net ([209.225.28.174]:35756 "EHLO
	mxsf42.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751159AbWCGFXT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:23:19 -0500
From: "Joseph D. Wagner" <technojoe@josephdwagner.info>
To: "'Xin Zhao'" <uszhaoxin@gmail.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Subject: RE: Why ext3 uses different policies to allocate inodes for dirs and files?
Date: Mon, 6 Mar 2006 23:24:25 -0600
Message-ID: <002601c641a7$6687d680$0201a8c0@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcZBZtJ1M3lfhg/pQfadEBHd4Ty/bAAP9wXA
In-Reply-To: <4ae3c140603061342r26ca2226s2e6e41792104c633@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The policy seems to distribute dir inodes uniformly on all block
> groups. Why do we want to do this?  Isn't it better to create a dir
> inode close to its parent dir inode?

Directories can, and frequently are, moved.  If you kept the dir inode close to its parent dir inode, you'd have to move dir inodes around every time you move directories.  Less is more.

Keeping the dir inodes uniform means the time to perform a name->inode lookup is relatively the same regardless of directory.  While admittedly this does not always yield the fastest performance, in this case we prefer consistency over speed.

I'm sure there are other good reasons too, but these two are enough to justify it.

Joseph D. Wagner

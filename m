Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbULXFUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbULXFUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 00:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbULXFUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 00:20:09 -0500
Received: from 210-192-132-157.adsl.ttn.net ([210.192.132.157]:43414 "EHLO
	tpe.accusys.com.tw") by vger.kernel.org with ESMTP id S261374AbULXFUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 00:20:05 -0500
Message-Id: <200412240517.iBO5HBB03592@tpe.accusys.com.tw>
Reply-To: <josephl@tpe.accusys.com.tw>
From: "Hao-Ran Liu" <josephl@accusys.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: Some questions about page cache 
Date: Fri, 24 Dec 2004 13:21:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcTpeHLcWM8bKR63TICLfDf6zg4wbg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I read kernel 2.6.9 page cache code and have some questions.

1. Is the call to filemap_fdatawrite() in sys_fsync() redundant? Since
sys_fsync() will call file->f_op->fsync(), and, both filemap_fdatawrite()and
file->f_op->fsync() (ext2, for example) eventually call do_writepages()
function.

2. for ext2, the purpose of sync_mapping_buffers() is to write out all
indirect blocks of an address_space, which is called by ext2_sync_file().
How do these buffers got synced when a user program called sys_sync()? I
don't find any call to ext2_sync_file() by sys_sync(). If
sync_mapping_buffers() is not needed for sys_sync(), then this should apply
for ext2_sync_file(), too?

Regards,
Hao-Ran Liu




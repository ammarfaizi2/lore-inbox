Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUBZI72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 03:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbUBZI72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 03:59:28 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:27396 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262716AbUBZI7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 03:59:25 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm4
Date: Thu, 26 Feb 2004 09:48:04 +0100
User-Agent: KMail/1.6.1
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, Andrew Morton <akpm@osdl.org>
References: <20040225185536.57b56716.akpm@osdl.org> <87eksidzci.fsf@lapper.ihatent.com>
In-Reply-To: <87eksidzci.fsf@lapper.ihatent.com>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402260947.52006@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ELbPAf/qUCtBoGV"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ELbPAf/qUCtBoGV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 26 February 2004 09:22, Alexander Hoogerhuis wrote:

Hi Alex,

> And a few symbols that are not exported?
> WARNING: /lib/modules/2.6.3-mm4/kernel/fs/quota_v2.ko needs unknown symbol
> mark_info_dirty WARNING: /lib/modules/2.6.3-mm4/kernel/fs/nfsd/nfsd.ko
> needs unknown symbol locks_remove_posix WARNING:
> /lib/modules/2.6.3-mm4/kernel/net/ipv6/ipv6.ko needs unknown symbol
> sysctl_optmem_max

Apply attached patch.

ciao, Marc



--Boundary-00=_ELbPAf/qUCtBoGV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.3-mm4-missing-exports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.3-mm4-missing-exports.patch"

--- old/fs/locks.c	2004-02-26 01:29:14.000000000 +0100
+++ new/fs/locks.c	2004-02-26 08:27:02.000000000 +0100
@@ -1699,6 +1699,8 @@ void locks_remove_posix(struct file *fil
 	unlock_kernel();
 }
 
+EXPORT_SYMBOL(locks_remove_posix);
+
 /*
  * This function is called on the last close of an open file.
  */
--- old/fs/dquot.c	2004-02-26 05:12:21.000000000 +0100
+++ new/fs/dquot.c	2004-02-26 08:28:26.000000000 +0100
@@ -1672,3 +1672,4 @@ EXPORT_SYMBOL(unregister_quota_format);
 EXPORT_SYMBOL(dqstats);
 EXPORT_SYMBOL(dq_list_lock);
 EXPORT_SYMBOL(dq_data_lock);
+EXPORT_SYMBOL(mark_info_dirty);
--- old/net/core/sock.c	2004-02-26 05:12:22.000000000 +0100
+++ new/net/core/sock.c	2004-02-26 08:30:01.000000000 +0100
@@ -1198,4 +1198,5 @@ EXPORT_SYMBOL(sock_wmalloc);
 #ifdef CONFIG_SYSCTL
 EXPORT_SYMBOL(sysctl_rmem_max);
 EXPORT_SYMBOL(sysctl_wmem_max);
+EXPORT_SYMBOL(sysctl_optmem_max);
 #endif

--Boundary-00=_ELbPAf/qUCtBoGV--

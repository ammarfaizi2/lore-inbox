Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbTHXP0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 11:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbTHXP0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 11:26:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261228AbTHXP0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 11:26:03 -0400
Date: Mon, 25 Aug 2003 01:25:48 +1000 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jamesm@excalibur.intercode.com.au
To: Christoph Hellwig <hch@infradead.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, <sds@epoch.ncsc.mil>
Subject: Re: selinux build failure
In-Reply-To: <20030824160245.A18526@infradead.org>
Message-ID: <Mutt.LNX.4.44.0308250124380.22060-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Aug 2003, Christoph Hellwig wrote:

> Argg, this is b0rked.  {asm,linux}/compat.h are for the 32bit compatiblity
> code.  64bit arches don't have fcntl64 - see the #if BITS_PER_LONG == 32
> around sys_fcntl64 in fcntl.c..

Indeed.  How about this?


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.0-test4.orig/security/selinux/hooks.c linux-2.6.0-test4.w1/security/selinux/hooks.c
--- linux-2.6.0-test4.orig/security/selinux/hooks.c	2003-08-23 11:53:14.000000000 +1000
+++ linux-2.6.0-test4.w1/security/selinux/hooks.c	2003-08-25 01:23:11.690432168 +1000
@@ -2057,9 +2057,11 @@
 		case F_GETLK:
 		case F_SETLK:
 	        case F_SETLKW:
+#if BITS_PER_LONG == 32
 	        case F_GETLK64:
 		case F_SETLK64:
 	        case F_SETLKW64:
+#endif
 			if (!file->f_dentry || !file->f_dentry->d_inode) {
 				err = -EINVAL;
 				break;


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVFVSmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVFVSmb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVFVSmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:42:31 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:12663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262502AbVFVSkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:40:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:date:user-agent:to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g7hrS836FpQqBZOjmv97OlHiySoGPa49XlucH2kFfrDHk/gCw38Fpbz5hgrcxnbljQ9ODKC3SntF0LfiKlugWRJXIYX21FQMWOquIxTjMwyYwFRX2tgWYSYN50AvyoJrGlbH5jsAKJL7ZByrnqZMUGz5d7DLuqgwol+HYtRpddw=
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Fwd: Re: [patch 1/3] __leify posix_acl_xattr_entry, posix_acl_xattr_header
Date: Wed, 22 Jun 2005 22:46:32 +0400
User-Agent: KMail/1.7.2
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven French <sfrench@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506222246.32763.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph, can you comment on what Steve said to my patch which is exactly
the same as yours acl-endianess-annotations.patch?
============================================================================
From: Steven French <sfrench@us.ibm.com>

You may be correct, but making the in memory representations of these
structions little endian seems wrong and I would be surprised if it were
little endian, but I have not had time to think through what happens when a
local filesystem takes an existing hard drive with ACLs on various inodes
and moves the drive from a little endian to a big endian machine and the
endian implications on this structure.

Although the representation on the wire for the cifs protocol is clearly
little endian for the acl entries, I am uncomfortable with changes to the
in memory representation until I do more checking.
============================================================================
--- 25/include/linux/posix_acl_xattr.h~acl-endianess-annotations
+++ 25-akpm/include/linux/posix_acl_xattr.h
@@ -23,13 +23,13 @@
 #define ACL_UNDEFINED_ID	(-1)
 
 typedef struct {
-	__u16			e_tag;
-	__u16			e_perm;
-	__u32			e_id;
+	__le16			e_tag;
+	__le16			e_perm;
+	__le32			e_id;
 } posix_acl_xattr_entry;
 
 typedef struct {
-	__u32			a_version;
+	__le32			a_version;
 	posix_acl_xattr_entry	a_entries[0];
 } posix_acl_xattr_header;
 

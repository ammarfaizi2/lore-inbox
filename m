Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVCBV4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVCBV4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVCBVsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:48:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:23473 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262564AbVCBVh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:37:27 -0500
Date: Wed, 2 Mar 2005 13:37:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 nfs oddity, file creation => "no such file"
Message-Id: <20050302133703.65e0b8f3.akpm@osdl.org>
In-Reply-To: <20050302191427.GA9383@hh.idb.hist.no>
References: <20050302191427.GA9383@hh.idb.hist.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> I observed an oddity on a nfs-mounted fs while using 2.6.11-rc5-mm1.

Could you try this please?

--- 25/fs/nfs/nfs3proc.c~nfsacl-acl-umask-handling-workaround-in-nfs-client-fix	2005-03-02 08:49:59.000000000 -0800
+++ 25-akpm/fs/nfs/nfs3proc.c	2005-03-02 08:49:59.000000000 -0800
@@ -423,6 +423,9 @@ exit:
 		if (!inode)
 			goto out;
 		status = nfs3_set_default_acl(dir, inode, mode);
+		if (status)
+			goto out;
+		return inode;
 	}
 out:
 	return ERR_PTR(status);
_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUBITBc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUBITBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 14:01:32 -0500
Received: from fungus.teststation.com ([212.32.186.211]:13575 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S265427AbUBITB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 14:01:29 -0500
Date: Mon, 9 Feb 2004 20:01:54 +0100 (CET)
From: Urban Widmark <Urban.Widmark@enlight.net>
X-X-Sender: puw@cola.local
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: SET_UID usage in smbfs
Message-ID: <Pine.LNX.4.44.0402091947010.25886-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

I'm wondering about this change in smbfs:

-		mnt->uid = OLD_TO_NEW_UID(oldmnt->uid);
-		mnt->gid = OLD_TO_NEW_GID(oldmnt->gid);
+		SET_UID(mnt->uid, oldmnt->uid);
+		SET_GID(mnt->gid, oldmnt->gid);

"OLD_TO_NEW_UID" took an old 16bit uid and returned a uid_t
(using low2highuid when appropriate).

SET_UID(var, uid) wants uid to be uid_t and may decide to use high2lowuid.

Was low2highuid not needed in the first place or is the change wrong?
It gives a compile warning about the comparison.


Bitkeeper lists the author as "ak@de[torvalds]". But it also says I'm 11
weeks late and that can't possibly be true ... :)

/Urban


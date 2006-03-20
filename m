Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWCTEpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWCTEpz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWCTEpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:45:54 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:2071 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751557AbWCTEpx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:45:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XNbab9vq+w7Rr9FTd/glyv29206G8ygZdajZ00+g9TrzMKTNiUZS+cmUnvlwIKIDiE7c5hA5vlosXLYc6GwjtNORdaVngTyEbBaJoGyCh2hDvr+8R2bN8DmXLkZqFibWl+BADrsqDb0rQxPL4+ZPVOrewa7dp76Crd9SgX7rvFg=
Message-ID: <787b0d920603192045y76e99e32p4ddde31961f80bb9@mail.gmail.com>
Date: Sun, 19 Mar 2006 23:45:52 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       akpm@osdl.org, ebiederm@xmission.com, janak@us.ibm.com,
       viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de, paulus@samba.org,
       mtk-manpages@gmx.net
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before we are committed.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The unshare() syscall is in fact a clone() syscall minus one
CLONE_* flag that is normally implied: CLONE_TASK_STRUCT.
(conceptually -- it has no name because it is always implied)

We already have one flag with inverted action: CLONE_NEWNS.
Adding another such flag (for the task struct) makes sense.
The new system call is thus not needed at all.

Suggested names: CLONE_NO_TASK, CLONE_SAMETASK, CLONE_SHARETASK

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVLYJpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVLYJpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 04:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVLYJpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 04:45:51 -0500
Received: from pat.uio.no ([129.240.130.16]:14217 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750809AbVLYJpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 04:45:50 -0500
Subject: Re: FS possible security exposure ?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: regatta <regatta@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
References: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 10:45:42 +0100
Message-Id: <1135503943.8032.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.22, required 12,
	autolearn=disabled, AWL 1.73, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-25 at 12:29 +0300, regatta wrote:
> Hi everyone,
> 
> I have a question regarding how Linux handle the files permission ,
> here is what I found
> 
> When logged on to a Linux workstation a user can edit a file (even if
> the file on an NFS-mounted NAS directory) if he has write access at
> the directory level, even if the file is owned by root (or any other
> user) and is read-only.

Since you do not explain how you performed the test, it is hard to
comment, but I don't see this behaviour you describe:

trondmy@lade test$ ls -al
total 12
drwxrwxrwx   2 root root 4096 2005-12-25 10:42 .
drwxrwxrwt  10 root root 4096 2005-12-25 10:41 ..
-rw-r--r--   1 root root    5 2005-12-25 10:42 test
trondmy@lade test$ cat >test
bash: test: Permission denied


If I use 'vi' to edit the file, then it can be modified, but the way vi
does that is to delete the old file, and create a new one with the same
name (and it will only do this if you use 'w!'). That should ordinarily
work on Solaris too.

Cheers,
  Trond


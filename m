Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271576AbTGQVrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271579AbTGQVrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:47:25 -0400
Received: from pat.uio.no ([129.240.130.16]:4345 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S271576AbTGQVrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:47:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16151.7350.505992.554003@charged.uio.no>
Date: Fri, 18 Jul 2003 00:01:26 +0200
To: torvalds@osdl.org, fcusack@fcusack.com
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Allow unattended nfs3/krb5 mounts
In-Reply-To: <20030717190428.GA4735@spaans.vs19.net>
References: <20030715232605.A9418@google.com>
	<20030717190428.GA4735@spaans.vs19.net>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

  Could we please back off the merging of these particular patches,
in order to give time for some critical debate?

  I'm glad Frank has been working on this, but if there has been a
proper debate on the merits of these patches, then I must have missed
it. I have indeed seen the patches pass through my inbox once, but I
have not had time yet to review them properly, and feed back my
comments to Frank.


  I have clear doubts about this patch.


  The 'fake root' inode does not appear to have a well defined
behaviour when it tries to circumvent revalidation rules. AFAICS
things like 'stat()', etc will at times tend to give odd results even
if the user does have the correct credentials.

  On a similar vein, I'm also unconvinced that there exist no races
between the lookup of new files, and the first setting of the
NFS_FILEID() on the root directory. fileid=1 is *not* a reserved inode
number under NFS v2 or v3, so it is perfectly legitimate for the
server to have other inodes with that number. In this case,
iget5_locked() may end up assigning the same inode to the root inode +
some other file.

  I also have questions about smaller issues, such as why we need a
full second RPC client in the superblock just in order to (very
temporarily) add a second authentication flavour.

Cheers,
  Trond

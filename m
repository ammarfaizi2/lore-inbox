Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTEWMcY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTEWMcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:32:24 -0400
Received: from pat.uio.no ([129.240.130.16]:1211 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264039AbTEWMcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:32:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16078.6065.300195.330411@charged.uio.no>
Date: Fri, 23 May 2003 14:44:33 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 0/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches add the concept of 'intents' to the VFS layer,
and are subsequently used to optimize the NFSv2/v3 close-to-open code,
and to add O_EXCL support.

Intents are a concept which have been pioneered under Linux by Peter
Braam. They are an optional field that is passed down to inode ops and
are used in order to pass down extra information to the filesystem
about the nature of the operation being undertaken.

This allows the filesystem in turn to make assumptions in order to
optimize away unnecessary operations (for instance under NFS - doing
both a LOOKUP and a GETATTR when doing an open), and to choose
variants that improve the atomicity (For instance under NFSv4 you
may choose to OPEN rather than LOOKUP).

So far, I have only implemented OPEN intents. In the future, it may
prove to be useful to add intents for other operations (I know the
Lustre project in particular is keen to do this) in order to optimize
away unnecessary file permission checks, and other such things.

As this does not impose additional demands on existing filesystems,
would this be possible as a late VFS change for 2.5.x/2.6.x?

The problems it addresses are listed in akpm's 'fix' list...

Cheers,
  Trond

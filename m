Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTIDCT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264520AbTIDCTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:19:08 -0400
Received: from pat.uio.no ([129.240.130.16]:8163 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264498AbTIDCSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:18:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16214.41175.580602.671154@charged.uio.no>
Date: Wed, 3 Sep 2003 22:17:59 -0400
To: Pascal Schmidt <der.eremit@email.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
In-Reply-To: <E19ujXl-0002Eb-00@neptune.local>
References: <rO94.822.25@gated-at.bofh.it>
	<rPop.1vp.13@gated-at.bofh.it>
	<E19ujXl-0002Eb-00@neptune.local>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Pascal Schmidt <der.eremit@email.de> writes:

     > That's assuming all NFSv3 servers do NFSv2 also. I don't. In
     > this case the bug was in my nfsd who was not recognizing the
     > filehandle coming in via GETATTR as correct. ;)

     > So I'll have to live with registering for V1 also and handling
     > umount there and rejecting mount with an error. Oh well.

No. That won't make any difference. The kernel never talks to the
mountd.

It's being handed a bogus filehandle by the userland mount command
(which gets it from mountd). When it sends the initial NFSv3 GETATTR
call to the nfsd, and gets rejected, it just retries the same GETATTR
call as an NFSv2 call.

     > Oh, BTW, that reminds me: the 2.6.0-test NFS client does not
     > like FSSTAT returning NFS3ERR_NOTSUPP. When I started coding, I
     > got a hard lockup of my system due to that, had to press the
     > reset button, not even Alt-SysRq wanted to work. I couldn't
     > capture the output and shutting down the system didn't work,
     > plus I could not start any new processes. Sure, that was a
     > buggy server, but should that lock up the kernel? Known
     > problem?

I'll check what's happening. AFAICS, the NFS layer should not really
care, but it will pass some funny values back to the VFS, and this
might be screwing something up...

Cheers,
  Trond

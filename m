Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271367AbTGQJ4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271368AbTGQJ4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:56:14 -0400
Received: from pat.uio.no ([129.240.130.16]:57256 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S271367AbTGQJ4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:56:13 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, zippel@linux-m68k.org,
       aebr@win.tue.nl, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
References: <20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213451.GA1964@win.tue.nl>
	<20030716143902.4b26be70.akpm@osdl.org>
	<20030716222015.GB1964@win.tue.nl>
	<20030716152143.6ab7d7d3.akpm@osdl.org>
	<20030717014410.A2026@pclin040.win.tue.nl>
	<20030716164917.2a7a46f4.akpm@osdl.org>
	<20030717082716.GA19891@ca-server1.us.oracle.com>
	<Pine.LNX.4.44.0307171037070.717-100000@serv>
	<20030717091515.GC19891@ca-server1.us.oracle.com>
	<20030717022444.19c204ef.akpm@osdl.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 17 Jul 2003 12:10:50 +0200
In-Reply-To: <20030717022444.19c204ef.akpm@osdl.org>
Message-ID: <shsy8yx79at.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@osdl.org> writes:

     > And surely the task of mangling whatever comes off the wire
     > into a dev_t for init_special_inode() should be private to the
     > Linux NFS client?

Well... Yes, but don't forget that it's not just a client issue but a
server issue too.

The NFSv2 'rdev' field is an unspecified 32-bit integer
format.
For NFSv3, you have a 32-bit major and a 32-bit minor number. Again
the mapping is unspecified by the protocol.

It all works by assuming that the client and server have agreed to use
the same format/conventions.

So if we want to retain backward compatibility with existing 2.4.x NFS
(and particularly NFSroot) clients/servers, then we want to ensure
that all numbers that are sent over the wire stay the same.

Cheers,
  Trond

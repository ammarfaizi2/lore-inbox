Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUFVU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUFVU6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUFVUtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 16:49:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:63195 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265932AbUFVUfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 16:35:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16600.38945.759248.188810@alkaid.it.uu.se>
Date: Tue, 22 Jun 2004 22:35:45 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
In-Reply-To: <20040622172025.GA6074@infradead.org>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
	<20040622085901.GA31971@infradead.org>
	<20040622020417.0ec87564.akpm@osdl.org>
	<20040622091219.GA32146@infradead.org>
	<20040622021441.4f6aa13c.akpm@osdl.org>
	<20040622091850.GA32160@infradead.org>
	<20040622022023.1942fd82.akpm@osdl.org>
	<16600.17486.81041.111276@alkaid.it.uu.se>
	<20040622172025.GA6074@infradead.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Tue, Jun 22, 2004 at 04:38:06PM +0200, Mikael Pettersson wrote:
 > > Swiching to open() on /proc/<pid>/<tid>/perfctr followed by ioctl()s
 > > would be easy to implement. But people @ LKML are sometimes violently
 > > opposed to ioctl()s, that's why the switch to syscalls happended.
 > 
 > I don't remember the details anymore, but lots of the syscalls could
 > really be read/write on special files.  I'll look through the code again
 > and send out draft API document.

I've thought about this, but the FS with multiple files approach
has several problems:

1. An open file descriptor no longer suffices as a user-space handle.
   This is because we don't have fd = open("%d/file",dirfd) type
   system calls.

2. A mini-fs under /proc/<pid>/<tid>/perfctr/ disappears when the
   process disappears. Currently, a process' perfctr state lives
   as long as references remains, whether via the process task_struct,
   or via some open file descriptor. One use for this is in
   remote-control applications, where it avoids enforcing
   parent/child relationships on monitor/target processes.

Going with a mini-fs is possible (though painful to implement), but
the remote-control feature would have to be constrained to a debugger
like model. In particular, the whole notion of using an fd as a handle
to a state object with its own lifetime would have to be ditched.

/Mikael

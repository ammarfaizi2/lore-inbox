Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTA1RRx>; Tue, 28 Jan 2003 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTA1RRx>; Tue, 28 Jan 2003 12:17:53 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:17164
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267436AbTA1RRw>; Tue, 28 Jan 2003 12:17:52 -0500
Subject: Re: PID of multi-threaded core's file name is wrong in 2.5.59
From: Robert Love <rml@tech9.net>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128154541.GA7269@nevyn.them.org>
References: <20030125.135611.74744521.maeda@jp.fujitsu.com>
	 <1043756485.1328.26.camel@dhcp22.swansea.linux.org.uk>
	 <20030128154541.GA7269@nevyn.them.org>
Content-Type: text/plain
Organization: 
Message-Id: <1043774823.9069.59.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Jan 2003 12:27:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 10:45, Daniel Jacobowitz wrote:

> I think this isn't an issue; multi-threaded core dumps are done by
> the core_waiter synchronization, so all other threads will have exited
> before the first thread to crash actually writes out its core.

I think the problem is the filenames need to not overwrite each other -
not actual synchronization in the kernel (which, as you point out, is
correct).

If we name the coredumps based on ->tgid, then all threads will dump to
the same file.  If we use ->pid, each thread will use its unique PID as
its filename.

	Robert Love


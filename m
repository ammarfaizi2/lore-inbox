Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSHIJWQ>; Fri, 9 Aug 2002 05:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318205AbSHIJWQ>; Fri, 9 Aug 2002 05:22:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58129 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318203AbSHIJWQ>;
	Fri, 9 Aug 2002 05:22:16 -0400
Message-ID: <3D538CF6.FBDFBE47@zip.com.au>
Date: Fri, 09 Aug 2002 02:35:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
References: <3D5381F7.1BCE0118@aitel.hist.no> <1028889153.28883.186.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Fri, 2002-08-09 at 09:48, Helge Hafting wrote:
> > Use 32-bit PID's, but with an additional rule for wraparound.
> > Simply wrap the PID when
> > (nextPID > 2*number_of_processes && nextPID > 30000)
> > The latter one just to avoid wrapping at 10 when there are
> > 5 processes.
> 
> Its much simpler to put max_pid into /proc/sys/kernel. That way we can
> boot with 32000 process ids, which will ensure ancient stuff which has
> 16bit pid_t (old old libc) and also any old kernel interfaces which
> expose it - does ipc ?

procfs oopses with >65535 processes, btw.  Related to the i_ino
encoding:

	#define fake_ino(pid,ino) (((pid)<<16)|(ino))
	#define PROC_INODE_PROPER(inode) ((inode)->i_ino & ~0xffff)

it ruined Anton's evening ;)

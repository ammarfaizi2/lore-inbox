Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSJUOIM>; Mon, 21 Oct 2002 10:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSJUOIM>; Mon, 21 Oct 2002 10:08:12 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:25012 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261387AbSJUOIL>; Mon, 21 Oct 2002 10:08:11 -0400
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Jacobowitz <dan@debian.org>
Cc: phil-list@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Mark Gross <markgross@thegnar.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021017164040.GA12608@nevyn.them.org>
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com>
	<Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain> 
	<20021017164040.GA12608@nevyn.them.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 15:29:33 +0100
Message-Id: <1035210573.28189.127.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 17:40, Daniel Jacobowitz wrote:
> My only problem with this is that you're waiting for all threads by
> SIGKILLing them.  If a process vforks or clones, and then the child
> crashes, the parent will receive a SIGKILL - iff we are dumping core. 
> That's a change in behavior that seems a bit too arbitrary to me.

It also has a security impact when you construct a fork/fork/crash
sequence that sends sigkill to the module loader or a kernel thread
during start up that has not yet dropped its association with the user
code.


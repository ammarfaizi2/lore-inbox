Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSHZNks>; Mon, 26 Aug 2002 09:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSHZNks>; Mon, 26 Aug 2002 09:40:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24316 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317984AbSHZNkr>; Mon, 26 Aug 2002 09:40:47 -0400
Subject: Re: problems with changing UID/GID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zheng Jian-Ming <zjm@cis.nctu.edu.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw>
References: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 14:45:51 +0100
Message-Id: <1030369551.1750.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 14:30, Zheng Jian-Ming wrote:
> POSIX states that the credentials (uid, gid, capabilities, etc.) are
> process-wide. So when one thread within the process changes some part
> of the credentials, all threads see the change.

For POSIX threads yes, for sane threading environments thats actually a
real pain in the backside. Currently its up to the pthreads userspace to
do the emulation itself. 

> But, the credentials are per-task in Linux, so it's possible to have
> two tasks in a process running under different UIDs.

Really useful isnt it

There are other reasons for wanting refcounted credential structures (eg
NFS writeback) so it may well be that once those go in for other reasons
it makes sense to provide an option to do shared credentials for
threaded apps. It is however nontrivial and you might want to see how
your other systems respond to things like a file open on a slow device
while a second thread is strobing the uid between two values. Does it
change uid mid syscall, does it get the permissions checks right if so ?

Its non trivial stuff, if not plain crazy to implement a literal
interpretation of (eg does a write fail half way if you change userid in
another thread ?)



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317072AbSH0VRF>; Tue, 27 Aug 2002 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSH0VRF>; Tue, 27 Aug 2002 17:17:05 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:46086 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S317072AbSH0VRE>; Tue, 27 Aug 2002 17:17:04 -0400
Date: Tue, 27 Aug 2002 14:21:02 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
Subject: Re: problems with changing UID/GID
Message-ID: <20020827212102.GA7541@bluemug.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, linux-kernel@vger.kernel.org
References: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw> <1030369551.1750.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030369551.1750.4.camel@irongate.swansea.linux.org.uk>
X-PGP-Key: http://web.bluemug.com/~miket/OpenPGP/5C09BB33.asc
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 02:45:51PM +0100, Alan Cox wrote:
> On Mon, 2002-08-26 at 14:30, Zheng Jian-Ming wrote:
> 
> > But, the credentials are per-task in Linux, so it's possible to have
> > two tasks in a process running under different UIDs.
> 
> Really useful isnt it
> 
> There are other reasons for wanting refcounted credential structures (eg
> NFS writeback) so it may well be that once those go in for other reasons
> it makes sense to provide an option to do shared credentials for
> threaded apps. It is however nontrivial and you might want to see how
> your other systems respond to things like a file open on a slow device
> while a second thread is strobing the uid between two values. Does it
> change uid mid syscall, does it get the permissions checks right if so ?
> 
> Its non trivial stuff, if not plain crazy to implement a literal
> interpretation of (eg does a write fail half way if you change userid in
> another thread ?)

Does POSIX really require that granularity of change?  Would an
implementation which, say, stored all credentials per-thread/task
and only picked up changes from other threads at kernel entry/exit
not be in spec?  That seems like a lower overhead solution than
locking all access to UIDs.

miket

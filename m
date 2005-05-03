Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVECQV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVECQV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVECQV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:21:29 -0400
Received: from citi.umich.edu ([141.211.133.111]:21115 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S261156AbVECQVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:21:25 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: "Michael Kerrisk" <michael.kerrisk@gmx.net>
Cc: "William A.(Andy) Adamson" <andros@citi.umich.edu>, matthew@wil.cx,
       sfr@canb.auug.org.au, mtk-lkml@gmx.net, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       andros@citi.umich.edu
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question 
In-reply-to: <5531.1115131813@www41.gmx.net> 
References: <20050503141552.F42371BAD1@citi.umich.edu> 
 <5531.1115131813@www41.gmx.net>
Comments: In-reply-to "Michael Kerrisk" <michael.kerrisk@gmx.net>
   message dated "Tue, 03 May 2005 16:50:13 +0200."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 May 2005 12:21:24 -0400
From: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Message-Id: <20050503162124.500F01BB40@citi.umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > On Tue, May 03, 2005 at 09:55:42AM -0400, William A.(Andy) Adamson
> > > wrote:
> > > > i believe the current implementation is correct. opening a file for
> > > > write 
> > > > means that you can not have a read lease, caller included.
> > > 
> > > Why not?  Certainly, others will not be able to take out a read lease,
> > > so there's very little point to only having a read lease, but I don't
> > > see why we should deny it.
> > > 
> > 
> > by definition: a read lease means there are no writers. so, the question
> > is 
> > not 'why not', the question is why? why hand out a read lease to an open
> > for write?
> 
> Andy,
> 
> Look more closely at my earlier table. 
> 
> Regardless of what the answer to your question is, the 
> current semantics are bizarre.  As things stand, a process
> can open a file O_RDWR, and and can place a WRITE lease 
> but not a READ lease.  That can't be right.

yes - i was being too strict. looking at NFSv4 delegations; a read lease does 
not mean there are no writers, it means there are no other clients (fl_owners) 
writing.

the other side of the coin would be break_lease. it should not break a read 
lease on an open for write in the case where the fl_owner of the read lease is 
also the owner of the open for write.

-->Andy 

> 
> FWIW it's worth, I think the read lease should be allowed.
> Oplocks are concerned with what other processes are doing, 
> not what the caller is doing.  Also, the current semantcis
> break backward compatibility.
> 
> Cheers,
> 
> Michael
> 
> -- 
> +++ Neu: Echte DSL-Flatrates von GMX - Surfen ohne Limits +++
> Always online ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVECOwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVECOwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVECOwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:52:46 -0400
Received: from imap.gmx.net ([213.165.64.20]:9451 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261654AbVECOuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:50:14 -0400
Date: Tue, 3 May 2005 16:50:13 +0200 (MEST)
From: "Michael Kerrisk" <michael.kerrisk@gmx.net>
To: "William A.(Andy) Adamson" <andros@citi.umich.edu>
Cc: matthew@wil.cx, andros@citi.umich.edu, sfr@canb.auug.org.au,
       mtk-lkml@gmx.net, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       andros@citi.umich.edu
MIME-Version: 1.0
References: <20050503141552.F42371BAD1@citi.umich.edu>
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
X-Priority: 3 (Normal)
X-Authenticated: #2864774
Message-ID: <5531.1115131813@www41.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Tue, May 03, 2005 at 09:55:42AM -0400, William A.(Andy) Adamson
> > wrote:
> > > i believe the current implementation is correct. opening a file for
> > > write 
> > > means that you can not have a read lease, caller included.
> > 
> > Why not?  Certainly, others will not be able to take out a read lease,
> > so there's very little point to only having a read lease, but I don't
> > see why we should deny it.
> > 
> 
> by definition: a read lease means there are no writers. so, the question
> is 
> not 'why not', the question is why? why hand out a read lease to an open
> for write?

Andy,

Look more closely at my earlier table. 

Regardless of what the answer to your question is, the 
current semantics are bizarre.  As things stand, a process
can open a file O_RDWR, and and can place a WRITE lease 
but not a READ lease.  That can't be right.

FWIW it's worth, I think the read lease should be allowed.
Oplocks are concerned with what other processes are doing, 
not what the caller is doing.  Also, the current semantcis
break backward compatibility.

Cheers,

Michael

-- 
+++ Neu: Echte DSL-Flatrates von GMX - Surfen ohne Limits +++
Always online ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl

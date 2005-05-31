Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVEaPlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVEaPlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVEaPlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:41:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:33251 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261912AbVEaPlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:41:52 -0400
Date: Tue, 31 May 2005 17:41:51 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: michael.kerrisk@gmx.net, sfr@canb.auug.org.au, heiko.carstens@de.ibm.com,
       linux-kernel@vger.kernel.org, andros@citi.umich.edu, matthew@wil.cx,
       schwidefsky@de.ibm.com
MIME-Version: 1.0
References: <20050531152328.GC22433@fieldses.org>
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <18351.1117554111@www82.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce,

> On Tue, May 31, 2005 at 04:53:50PM +0200, Michael Kerrisk wrote:
> > I applied this against 2.6.12-rc4, and it fixes the problem 
> > (and I've also teasted various other facets of file leases 
> > and this change causes no obvious breakage elsewhere).
> > 
> > Are you going to push this fix into 2.6.12?
> 
> Are you sure this is actually a problem?
> 
> I still have the following questions I had before:
> 
> > I'm a little confused as to why anyone would have the expectation
> > that read leases would not conflict with write opens by the same
> > process, given that break_lease() has never functioned that way, so
> > later write opens by the same process have always broken any read 
> > lease.
> >
> > Are there applications that actually depend on the old behaviour?  Is
> > there any documentation that blesses it?  All I can find is the fcntl
> > man page, and as far as I can tell an implementation that makes read
> > leases conflict with all write opens (by the same process or not) is
> > consistent with that man page.

I believe it is still a problem: primarily because it broke
old behavior for no apparent reason (Stephen Rothwell, who was 
one of the original implementers seems to agree, since he 
suggested that one line patch).  I suspect the change was 
unintentional.

By the way, I wrote the text in the fcntl() man page
by looking at the code and experimenting.  There was no 
existing documentation of F_SETLEASE.  I'm questioning 
the change based on my understanding of how things should 
work (I didn't happen to write up this point because it 
seemed self-evident *to me*); however, I know rather 
little of the workings of SAMBA.

Cheers,

Michael

-- 
Weitersagen: GMX DSL-Flatrates mit Tempo-Garantie!
Ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl

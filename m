Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUFFRsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUFFRsB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUFFRqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:46:33 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:28559 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263895AbUFFRny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:43:54 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 6 Jun 2004 10:43:47 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
cc: Paul Rolland <rol@as2917.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <s5g4qpo4p40.fsf@patl=users.sf.net>
Message-ID: <Pine.LNX.4.58.0406061025460.28693@bigblue.dev.mdolabs.com>
References: <E1BWuK1-0003PT-00@calista.eckenfels.6bone.ka-ip.net>
 <200406061307.i56D7pX26872@tag.witbe.net> <s5g4qpo4p40.fsf@patl=users.sf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004, Patrick J. LoPresti wrote:

> "Paul Rolland" <rol@as2917.net> writes:
> 
> > Hello,
> > 
> > > It does that  for the unique  filenames and id stamps 
> > > (maildir format and
> > 
> > I though this was a job for mktemp and co.
> 
> Sure, if you want to create a unique filename on a local unshared
> disk.
> 
> But suppose you want a unique filename on a partition which might be
> NFS-mounted with multiple concurrent writers.  Oh, and the year is
> 1997.  Still want to use mktemp?
> 
> Bernstein decided to name each file:
> 
>     <time>.<PID>.<fully-qualified-domain-name>
> 
> This approach makes three assumptions.  First, that the time does not
> repeat.  Second, that the FQDN is unique.  Third, that the time
> changes (i.e., one second elapses) before a PID is reused on the local
> system.  Subject to these assumptions, this is a perfectly reliable,
> very efficient, lock-free way to create unique file names.

As long as 1) your program is not MT 2) your process creates exactly *one* 
unique file. Then yes, it is fine. But, if your program is MT (with 
threads sharing the PID) or your single thread process creates two (or 
more) unique files within 1 sec, you've got a problem. Using gettid() 
would solve the MT issue (there's still the tid recycling period), but not 
the time issue.



- Davide


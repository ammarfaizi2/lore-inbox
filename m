Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263840AbUFFRVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUFFRVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUFFRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:21:05 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:29702 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S263840AbUFFRUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:20:53 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g4qpo4p40.fsf@patl=users.sf.net>
To: "Paul Rolland" <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <200406061307.i56D7pX26872@tag.witbe.net>
References: <E1BWuK1-0003PT-00@calista.eckenfels.6bone.ka-ip.net> <200406061307.i56D7pX26872@tag.witbe.net>
Date: 06 Jun 2004 13:20:49 -0400
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul Rolland" <rol@as2917.net> writes:

> Hello,
> 
> > It does that  for the unique  filenames and id stamps 
> > (maildir format and
> 
> I though this was a job for mktemp and co.

Sure, if you want to create a unique filename on a local unshared
disk.

But suppose you want a unique filename on a partition which might be
NFS-mounted with multiple concurrent writers.  Oh, and the year is
1997.  Still want to use mktemp?

Bernstein decided to name each file:

    <time>.<PID>.<fully-qualified-domain-name>

This approach makes three assumptions.  First, that the time does not
repeat.  Second, that the FQDN is unique.  Third, that the time
changes (i.e., one second elapses) before a PID is reused on the local
system.  Subject to these assumptions, this is a perfectly reliable,
very efficient, lock-free way to create unique file names.

Can you do better?

Sure, Bernstein's code is an unmaintainable nightmare.  But his
designs and implementations are usually pretty sound.  The last
release of qmail was in 1998, and we still use it where I work.  Six
years with zero crashes, zero dropped messages, and zero security
holes is not a trivial track record for an MTA.

Just don't ever try to edit the sources.  :-)

 - Pat

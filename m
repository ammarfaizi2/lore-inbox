Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161210AbWJRQEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161210AbWJRQEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWJRQEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:04:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63899 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161210AbWJRQEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:04:09 -0400
Subject: Re: [linux-pm] [PATCH] Block on access to temporarily unavailable
	pci device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Matthew Wilcox <matthew@wil.cx>, Brian King <brking@us.ibm.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Adam Belay <abelay@MIT.EDU>
In-Reply-To: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0610181151450.6766-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2006 17:05:02 +0100
Message-Id: <1161187503.9363.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 11:52 -0400, ysgrifennodd Alan Stern:
> Don't you want the user process to wait in TASK_INTERRUPTIBLE?  It would 
> require only a very simple change.

That just makes the problem even worse, to go with the kernel driver
"what the hell do do if.." we get a user space one thats based around
incompatibility with the existing behaviour.

There are much saner ways to sort that out without breaking the API

If its going to be a bounded short wait -> pause
If its might be a long wait -> cached
If its gone for good then error

If the user specified O_NDELAY then -EWOULDBLOCK not wait

That way you don't break anything and you get sensible Unix semantics.
The wait queue Matthew added also means select() can be fitted up to do
the right thing for the O_NDELAY case.

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293024AbSCOR65>; Fri, 15 Mar 2002 12:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293020AbSCOR6k>; Fri, 15 Mar 2002 12:58:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18137 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293010AbSCOR6Y>;
	Fri, 15 Mar 2002 12:58:24 -0500
Message-ID: <3C92361B.B70DACFD@us.ibm.com>
Date: Fri, 15 Mar 2002 09:57:47 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ecki-news2002-02@lina.inka.de
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd wrote...
> Yes, I think it is at least needed to share the ring buffer.

Ideally, you are right.  But messing around with the printk
functionality is risky and could be unpopular in the community,
especially if you are only conserving what really amounts to
a small amount of memory (16,32 or 64K, for printk ring buffer).

> Posix and BSD Auditing events are an example for that. In secure mode
> the
> system must be halted on overflow. a printk replacement will want to
> keep the
> oldest entries and a enterprise event system may want to keep the
> oldest.

So I think what you want is to set a "watch" for certain events and
when those event(s) are written to the buffer (1) trigger some action, 
like halting the machine, and (2) save the last n events leading-up to 
the trigger-action.  You might also want to initiate a crash-dump and 
be able to retrieve the pinned events from the dump.

Am I on the right track ?  Can you give me some idea which information
you would watch for in the events (facility, severity, event_type,
etc.)?  

> And I think a flexible policy will allow everybody to
> be
> happy with your framework. the only way to get it accepted, right?

Its not clear that the sort of requirement you are describing...
...In secure mode the system must be halted on overflow...
is needed by the majority of potential event logging users, so could
what you are asking for be implemented as a kernel module ?

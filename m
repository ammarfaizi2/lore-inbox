Return-Path: <linux-kernel-owner+w=401wt.eu-S936577AbWLITve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936577AbWLITve (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936531AbWLITve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:51:34 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:14921 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933278AbWLITvd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:51:33 -0500
Subject: Re: [PATCH] WorkStruct: Fix S390 driver workstruct usage
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux390@de.ibm.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <20061208173342.GT4587@ftp.linux.org.uk>
References: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com>
	 <20061208173342.GT4587@ftp.linux.org.uk>
Content-Type: text/plain
Organization: IBM Corporation
Date: Sat, 09 Dec 2006 20:51:09 +0100
Message-Id: <1165693869.17186.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 17:33 +0000, Al Viro wrote:
> I don't think it's a real fix.
> 
> a) what protects tty from disappearing?

Nothing..

> b) why the hell do we need that schedule_work() at all?  handle_sysrq() is
> supposed to be safe to use from irq handler; when needed it does arrange for
> delayed execution itself.

Fritz probably did that because earlier versions of handle_sysrq() could
not be called in interrupt context. ctrlchar.c is rather old, the first
checkin I can see is from 2001/01/18. 

> So how about we simply call handle_sysrq() there and be done with that?
> Martin?

If it works that is fine with me. Another simplification. I take a look
at it next week.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.



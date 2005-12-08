Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVLHQP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVLHQP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVLHQP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:15:28 -0500
Received: from web34104.mail.mud.yahoo.com ([66.163.178.102]:53390 "HELO
	web34104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932191AbVLHQP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mM88Z4W9KJMl1LZfHcqG0uErBuQu3pfJOdRqKu/PhGoMW5rmVfOMxo1qyN3XgzOzyn9VFFA/VsGhQHe3l25srliUjl235KO4stYuWI7hOWrZsuXXEhAfHc/D6kwjwGmnyOvOa/axpqkvDmicFYtRfKlR9HYjV5Elr1DF5ZINLoA=  ;
Message-ID: <20051208161525.88155.qmail@web34104.mail.mud.yahoo.com>
Date: Thu, 8 Dec 2005 08:15:25 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs question - ftruncate vs pwrite
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Peter Staubach <staubach@redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1134017608.8002.55.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> That is as expected. The ftruncate() causes an immediate change in
> length of the file on the server, and so reads will. In the case of
> pwrite(), that is cached on the client until you fsync/close, and so the
> server returns short reads.
> 
> > Since this is using the buffer cache (not opened with O_DIRECT), and since we know we are
> > extending the file... is it strictly necessary to read in pages of 0's from the server?
> 
> Possibly not, but is this a common case that is worth optimising for?

I am attempting to write a low-latency logger.  'Low' meaning a system call is too slow (measured
at 0.3 microseconds) for each message.  So I am trying to use the page cache to handle the
background scheduling of bulk writes to the server, and as an extra layer of reliability in the
event of a program crash.  The use of pwrite seems to be the best option at this time as spending
a few milliseconds for an ftruncate to a show-stopper.

I could also just write locally into a shared memory region, and have my own background copy to
the server, but this seems a bit wasteful when the page cache does most of this already, and can
optimize page-sized writes.

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

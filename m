Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTH1UYa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTH1UYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:24:30 -0400
Received: from mail.webmaster.com ([216.152.64.131]:767 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S264256AbTH1UY2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:24:28 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Timo Sirainen" <tss@iki.fi>
Cc: "Jamie Lokier" <jamie@shareable.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Lockless file reading
Date: Thu, 28 Aug 2003 13:24:23 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEDLFMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1062066411.1451.319.camel@hurina>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2003-08-28 at 12:56, David Schwartz wrote:

> > > > You said that MD5 wasn't strong enough, and you would like
> > > > a guarantee.

> > > Yes. I don't really like it if my program heavily relies on something
> > > that can go wrong in some situations.

> > 	Okay, this is too much. Your alternative, assuming the kernel won't
> > re-order writes, is clearly relying on something that can go wrong.

> Reorder on per-byte basis? Per-page/block would still be acceptable.

	There is no law that says the kernel can't re-order on a per-byte basis.
Memory visibility and posted writes could, at least in theory, result in
this outcome today. Future technology may make it even more probable.

> Anyway, the alternative would be shared mmap()ed file. You can trust
> 32bit memory updates to be atomic, right?

	Yes, but you can't trust that multiple 32 bit memory updates won't be seen
out of order by another processor without appropriate barriers or
synchronization.

> Or what about: write("12"), fsync(), write("12")? Is it still possible
> for read() to return "1x1x"?

	I believe it still is. The 'fsync' function does not synchronize another
process' view of memory. It is not a memory barrier and, in any event, if it
was a memory barrier it would be running in the wrong place. The 'fsync'
function syncs the memory with stable storage, it does not synch (or at
least, it is not guaranteed to sync) with the memory view of another
process.

	Nothing stops speculative reads for the two halves of the data, each in
their own 32-bit unit, from crossing in time. Even if it's not possible on
today's hardware, it is still possible in principle.

	DS



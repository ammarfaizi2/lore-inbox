Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268314AbTGIP3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268351AbTGIP3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:29:19 -0400
Received: from fmr03.intel.com ([143.183.121.5]:51431 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268314AbTGIP3S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:29:18 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Redundant memset in AIO read_events
Date: Wed, 9 Jul 2003 08:43:53 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B00F79@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Redundant memset in AIO read_events
Thread-Index: AcNGGW7FsxaN5J9NSJiK0LVk/z7VbgAFnoig
From: "Luck, Tony" <tony.luck@intel.com>
To: "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
X-OriginalArrivalTime: 09 Jul 2003 15:43:54.0292 (UTC) FILETIME=[E6E92740:01C34630]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > OK, here is another one.  In the top level read_events() function in
> > fs/aio.c, a struct io_event is instantiated on the stack 
> (variable ent).
> > It calls aio_read_evt() function which will fill the entire io_event
> > structure into variable ent.  What's the point of zeroing when copy
> > covers the same memory area?  Possible a debug code left around?
> 
> Read the comment before that memset. The structure might contain some
> padding (bytes not belonging to any of its entries), these bytes are
> random and if you do not zero them, you copy random data into 
> userspace.

That is true, but here's the definition of the io_event strcuture:

struct io_event {
        __u64           data;
        __u64           obj;
        __s64           res;
        __s64           res2;
};

In the words of the comment, C may be "fun", but I've
having trouble envisioning an architecture where a structure
that consists of four equal sized objects has some padding!

Don't we usually call code that defends against impossible
problems "bloat"?

-Tony

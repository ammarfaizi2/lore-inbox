Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264938AbUELK1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbUELK1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 06:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUELK1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 06:27:05 -0400
Received: from fmr06.intel.com ([134.134.136.7]:57262 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264983AbUELK0P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 06:26:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Who owns those locks ?
Date: Wed, 12 May 2004 03:25:19 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F013CCAED@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Who owns those locks ?
Thread-Index: AcQ4B0eRiRTHNhT3R6SYR8vUTTV2CgAAe59w
From: "Luck, Tony" <tony.luck@intel.com>
To: <Zoltan.Menyhart@bull.net>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 May 2004 10:25:20.0288 (UTC) FILETIME=[6D4E9A00:01C4380B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The current task pointers are identity mapped memory addresses.
>I shift them to the right by 12 bits (these bits are always 0-s).
>In that way, addresses up to 16 Tbytes can fit into the lock word.

Neat trick.  Will work for most people ... but watch out if you
have an architecture that has sparse physical address space and
can thus potentially allocate a task structure on a 16TB boundary.

At first I thought SGI Altix could be hurt by this, but they are
saved by the fact that bits [37:36] are always set to one.

I know of at least one 1TB machine now, so 16TB machines are only
a few years away.  You could stretch the life of this patch by
using PAGE_SHIFT, rather than 12 (as practically nobody builds
kernels with a 4k pagesize, especially not on monster machines).

Or perhaps just fix the allocation of task structures to skip
around the 16TB aligned ones?

-Tony

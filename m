Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbULHSaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbULHSaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbULHSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:30:06 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:387 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261296AbULHS34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:29:56 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Figuring out physical memory regions from a kernel module
Date: Wed, 8 Dec 2004 11:28:53 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C20596020D@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Figuring out physical memory regions from a kernel module
Thread-Index: AcTdT60/8CGUmNG2R1iGWFoNM3tGyAAAJd/A
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <haveblue@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2004 18:28:54.0626 (UTC) FILETIME=[C5F2BC20:01C4DD53]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Dave Hansen [mailto:haveblue@us.ibm.com] 
Sent: Wednesday, December 08, 2004 10:58 AM
To: Hanson, Jonathan M
Cc: Linux Kernel Mailing List
Subject: Re: Figuring out physical memory regions from a kernel module

On Wed, 2004-12-08 at 09:44, Hanson, Jonathan M wrote:
> 	Is there a reliable way to tell from a kernel module (currently
> written for 2.4 but will need to work under 2.6 in the future) which
> regions of physical memory are actually available for the kernel and
> processes to use?

Is this a rehashing of the "Walking all the physical memory in an x86
system" thread? :)

Why don't you just tell us what you're actually trying to do in your
module.  There's probably a better way.

-- Dave

[Jon M. Hanson] The module is dumping the contents of physical memory
and saving the architecture state of the system to a file when triggered
(ioctl call). What I have works but I need to extend it to systems other
than my own where I have hard-coded the system RAM regions into the
code. I need the physical addresses of memory because the tool I feed
this output into requires this. Here is an example of what the memory
file looks like:

/origin 00000000
00000001
f0005646
f000e2c3
    .
    .
    .

Memory contents that are all zero are not printed out but another origin
statement must be printed out when a non-zero memory location is
encountered after the optionally multiple locations with zero. All
origin addresses are double-word physical addresses.

Initially I mistakenly thought I could just write a loop that began at
__pa(PAGE_OFFSET) and went to total_ram_pages * PAGE_SIZE. This worked
somewhat but was not traversing all of the memory due to the "holes" in
the RAM (like the 1 M hole and memory-mapped I/O). I hard-coded the
actual "System RAM" locations obtained via:

cat /proc/iomem | grep 'System RAM'

into the code and now I can be sure that I'm getting all of the RAM I'm
intending to get. This will work on this one system only reliably so now
I'm trying to figure out those arbitrary ranges automatically from my
kernel module.

I'm currently trying to figure out these ranges by just traversing the
mem_map array and recording what addresses are in use there. I'm not
sure that's going to work out, though.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbUEADbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUEADbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUEADbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:31:45 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:34003
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S261798AbUEADbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:31:41 -0400
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
From: Michael Brown <mebrown@michaels-house.net>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <m3r7u59sok.fsf@averell.firstfloor.org>
References: <1QvX0-A4-29@gated-at.bofh.it>
	 <m3r7u59sok.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1083382204.1203.2971.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Apr 2004 22:30:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 14:22, Andi Kleen wrote:
> Michael Brown <mebrown@michaels-house.net> writes:
> 
> > 	Below is an updated patch to add SMBIOS information to /proc/smbios.
> > Updates have been made per Al's previous comments. Please apply.
> 
> What is this good for? There are tools to read this from
> /dev/mem; and that is fine because the information is static.
> There is no reason to bloat the kernel with this.

As I mentioned in my first posting of this to l-k, there are three
reasons why this driver is necessary:

-- This information is, in the very near future, _not_ going to be
static anymore. There will be systems that update the information in
dynamically during SMIs.

-- SMBIOS consists of two things, the table entry point and the table
itself. The table entry point is always in 0xF0000 - 0xFFFFF.
Traditionally, the actual table has been here as well. BIOS is running
out of space here and future systems are moving this information to high
memory. /dev/mem will not allow access to memory above top of system
RAM.

-- Red Hat has a /dev/mem patch in their tree that restricts access to
RAM above 1MB. 

Because of all of these reasons, we feel it is a good thing to have a
stable method to get to the SMBIOS information that will work into the
future. Our userspace libs will try to use this driver to access SMBIOS,
but fall back to /dev/mem if this driver is not available. (with the
caveat that nothing will work if table >1MB and this driver not
present.)

As for the "bloat" argument: this driver is about the most trivial
driver I can conceive of that does useful work. It is 250 raw lines of
code, comparable in size to /proc/meminfo or /proc/cpuinfo. 

This 250 line driver allows us to move a few thousand lines of code from
Dell's current, proprietary systems management driver into userspace. If
this approach is accepted, I am pushing to work on opening up other
pieces of Dell's current proprietary drivers. This work is a
proof-of-concept to management that this approach can work.
--
Michael




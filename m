Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVI3PYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVI3PYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVI3PYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:24:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20865 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030333AbVI3PYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:24:04 -0400
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
From: Dave Hansen <haveblue@us.ibm.com>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050930073232.10631.63786.sendpatchset@cherry.local>
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 08:23:44 -0700
Message-Id: <1128093825.6145.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
> These patches implement NUMA memory node emulation for regular i386 PC:s.
> 
> NUMA emulation could be used to provide coarse-grained memory resource control
> using CPUSETS. Another use is as a test environment for NUMA memory code or
> CPUSETS using an i386 emulator such as QEMU.

This patch set basically allows the "NUMA depends on SMP" dependency to
be removed.  I'm not sure this is the right approach.  There will likely
never be a real-world NUMA system without SMP.  So, this set would seem
to include some increased (#ifdef) complexity for supporting SMP && !
NUMA, which will likely never happen in the real world.

Also, I worry that simply #ifdef'ing things out like CPUsets' update
means that CPUsets lacks some kind of abstraction that it should have
been using in the first place.  An #ifdef just papers over the real
problem.  

I think it would likely be cleaner if the approach was to emulate an SMP
NUMA system where each NUMA node simply doesn't have all of its CPUs
online.

-- Dave


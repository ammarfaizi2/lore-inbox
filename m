Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbTILRsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbTILRsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:48:52 -0400
Received: from zok.SGI.COM ([204.94.215.101]:12951 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261166AbTILRsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:48:46 -0400
Date: Fri, 12 Sep 2003 10:48:07 -0700
To: Anthony Dominic Truong <anthony.truong@mascorp.com>,
       linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       willy@debian.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912174807.GA629@sgi.com>
Mail-Followup-To: Anthony Dominic Truong <anthony.truong@mascorp.com>,
	linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
	willy@debian.org
References: <20030911192550.7dfaf08c.ak@suse.de> <1063308053.4430.37.camel@huykhoi> <20030912162713.GA4852@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912162713.GA4852@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, Andi asked for benchmarks, so I ran some.  Let this should be a
lesson on why you shouldn't use port I/O :)  I ran these on an SGI Altix
w/900 MHz McKinley processors.

Just straight calls to the routines (all of these are based on the
average of 100 iterations):
  writeq(val, reg) time: 64 cycles
  outl(val, reg) time: 2126 cycles

A simple branch:
  if (use_mmio)
	writeq(val, reg) time: 132 cycles
  else
	outl(val, reg) time: 1990 cycles

Using a wrapper to point to one of the routines:
  wrapper->write(val, reg) time: 215 cycles
  wrapper->out(val, reg) time: 3931 cycles

Thanks,
Jesse

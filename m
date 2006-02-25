Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbWBYTBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbWBYTBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWBYTBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:01:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:11245 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1161059AbWBYTBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:01:14 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602251428.01767.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200602250543.22421.ak@suse.de>
	 <1140852894.2587.43.camel@localhost.localdomain>
	 <200602251428.01767.ak@suse.de>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 11:01:23 -0800
Message-Id: <1140894083.9852.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 14:28 +0100, Andi Kleen wrote:

> Before we can add such a macro I suspect you would first 
> need to provide some spec how that "portable write combining"
> is supposed to work and get feedback from the other architectures.

It seems like we'd need a function that tries to enable or disable write
combining on an MMIO memory range.  This would be implemented by arches
that support it, and would fail on others.  Drivers could then try to
enable write combining, and if it failed, either bail, print a warning
message, or do something else appropriate.

So on i386 and x86_64, this function would fiddle with the MTRRs.  On
powerpc, it would either configure the northbridge appropriately or
fail.  On other arches, I don't know enough to say, so the default would
be to fail.

Is this reasonable?  I can code a strawman implementation up, if the
basic idea looks sane.

	<b


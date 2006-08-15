Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWHOGvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWHOGvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965238AbWHOGvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:51:47 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:33978 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965236AbWHOGvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:51:46 -0400
Date: Tue, 15 Aug 2006 02:46:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [140/145] i386: mark cpu_dev
  structures as __cpuinitdata
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Message-ID: <200608150249_MC3-1-C823-B57B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1155518783.5764.10.camel@localhost>

On Mon, 14 Aug 2006 10:26:23 +0900, Magnus Damm wrote:

> > > The different cpu_dev structures are all used from __cpuinit callers what
> > > I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
> > > little bit unsure about arch/i386/common.c:default_cpu, especially when it
> > > comes to the purpose of this_cpu.
> > 
> > But none of these CPUs supports hotplug and only one (AMD) does SMP.
> > So this is just wasting space in the kernel at runtime.
> 
> How could this be wasting space? If you compile with CONFIG_HOTPLUG_CPU
> disabled then __cpuinitdata will become __initdata - ie the same as
> before. Not a single byte wasted what I can tell.

I was talking about wasted space with HOTPLUG_CPU enabled, of course.
Nobody is ever going to hotplug a VIA, Cyrix, Geode, etc. CPU, yet your
patch makes the kernel carry that code and data anyway.

Yes, the checking scripts will complain.  But we know it's OK.

-- 
Chuck


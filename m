Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965383AbWHORAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbWHORAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWHORAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:00:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50848 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752120AbWHORAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:00:16 -0400
Date: Tue, 15 Aug 2006 12:59:47 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH for review] [140/145] i386: mark cpu_dev structures as __cpuinitdata
Message-ID: <20060815165947.GE7612@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Magnus Damm <magnus@valinux.co.jp>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>
References: <200608150249_MC3-1-C823-B57B@compuserve.com> <1155627804.3011.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155627804.3011.46.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 09:43:23AM +0200, Arjan van de Ven wrote:
 > On Tue, 2006-08-15 at 02:46 -0400, Chuck Ebbert wrote:
 > > In-Reply-To: <1155518783.5764.10.camel@localhost>
 > > 
 > > On Mon, 14 Aug 2006 10:26:23 +0900, Magnus Damm wrote:
 > > 
 > > > > > The different cpu_dev structures are all used from __cpuinit callers what
 > > > > > I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
 > > > > > little bit unsure about arch/i386/common.c:default_cpu, especially when it
 > > > > > comes to the purpose of this_cpu.
 > > > > 
 > > > > But none of these CPUs supports hotplug and only one (AMD) does SMP.
 > > > > So this is just wasting space in the kernel at runtime.
 > > > 
 > > > How could this be wasting space? If you compile with CONFIG_HOTPLUG_CPU
 > > > disabled then __cpuinitdata will become __initdata - ie the same as
 > > > before. Not a single byte wasted what I can tell.
 > > 
 > > I was talking about wasted space with HOTPLUG_CPU enabled, of course.
 > > Nobody is ever going to hotplug a VIA, Cyrix, Geode, etc. CPU, yet your
 > > patch makes the kernel carry that code and data anyway.
 > 
 > remember that suspend uses software hot(un)plug as well...

Only for non-boot CPUs. The vendors above (with exception of VIA)
never made SMP systems.

		Dave
-- 
http://www.codemonkey.org.uk

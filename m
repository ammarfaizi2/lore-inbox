Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSIAUNL>; Sun, 1 Sep 2002 16:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSIAUNL>; Sun, 1 Sep 2002 16:13:11 -0400
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:43782 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S317422AbSIAUNK>;
	Sun, 1 Sep 2002 16:13:10 -0400
Subject: Re: [PATCH] Re: 2.5.33 PNPBIOS does not compile
From: Ray Lee <ray-lk@madrabbit.org>
To: ldb@ldb.ods.org, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Sep 2002 13:17:34 -0700
Message-Id: <1030911455.4803.3.camel@orca>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

> #define Q_SET_SEL(cpu, selname, address, size) \
>  set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
> -set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
> +set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)
 
>  #define Q2_SET_SEL(cpu, selname, address, size) \
>  set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
> -set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
> +set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)

These look very wrong. They're not wrapped in the standard do {...}
while(0) protection, and used inside bare if statements below. Can
someone who knows the code verify that these should be wrapped?

(Not, mind you, that I'm complaining about your patch. You didn't
introduce the problem, it just caught my eye.)

Ray


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSIEXeU>; Thu, 5 Sep 2002 19:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318243AbSIEXeU>; Thu, 5 Sep 2002 19:34:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52999 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318229AbSIEXeT>; Thu, 5 Sep 2002 19:34:19 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH][2.4.20-pre5] non syscall gettimeofday
Date: 5 Sep 2002 16:38:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <al8ptr$up3$1@cesium.transmeta.com>
References: <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net>
By author:    Stephen Hemminger <shemminger@osdl.org>
In newsgroup: linux.dev.kernel
> 
> The following patch implements a shared memory interface to allow
> implementing gettimeofday (and other clock measurement) using the TSC
> counter on i386.  On a 1.6G Xeon this reduces gettimeofday from 1.2 us
> per call to .17 us per call.
> 

This sounds like a vsyscall.  Since we have discussed vsyscalls on and
off without getting anywhere, I'd like to know how your implementation
does it -- the #1 proposal I think was to map in a page at 0xfffff000
and have the vsyscall code there.

Note that the vsyscall needs to bounce to a regular syscall if TSC
time/gettimeofday aren't available.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

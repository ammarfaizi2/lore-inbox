Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264410AbRFIQ6V>; Sat, 9 Jun 2001 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264409AbRFIQ6L>; Sat, 9 Jun 2001 12:58:11 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:10112
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S264401AbRFIQ6D>; Sat, 9 Jun 2001 12:58:03 -0400
Date: Sat, 9 Jun 2001 09:56:53 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200106091656.f59Gurx10167@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: kaos@ocs.com.au, Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing symbol do_softirq in net moduels for pre-2 
In-Reply-To: <16339.992103452@ocs4.ocs-net>
In-Reply-To: <01060911075200.00993@oscar> <16339.992103452@ocs4.ocs-net>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, Keith Owens wrote:

> On Sat, 9 Jun 2001 Ed Tomlinson <tomlins@cam.org> wrote:
>
> > Built -pre2 and noticed most of the modules in net/* are getting 
> > a missing symbol for do_softirq.  
>
> http://www.tux.org/lkml/#s8-8

Hmm, I don't think this is it--I'm seeing the same thing, and I have
tried 'make mrproper'.  All symbols are getting versionated except
certain calls to do_softirq() in, e.g., sunrpc.o and the iptables
modules.

I looked into this, and I believe the problem is due to 2.4.6-pre2's
change to the i386 local_bh_enable() macro--the C version has been
replaced with an assembly language version that does "call
do_doftirq;".  Perhaps this function call from the assembly language
version does not get versionated?  

Cheers, Wayne




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbTAXGUS>; Fri, 24 Jan 2003 01:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTAXGUS>; Fri, 24 Jan 2003 01:20:18 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:16303
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267564AbTAXGUR>; Fri, 24 Jan 2003 01:20:17 -0500
Subject: Re: Using O(1) scheduler with 600 processes.
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
In-Reply-To: <435060000.1043389112@titus>
References: <1043367029.28748.130.camel@UberGeek>
	 <310350000.1043367864@titus> <1043388556.12894.23.camel@localhost>
	 <435060000.1043389112@titus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043389673.14486.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 24 Jan 2003 00:27:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-24 at 00:18, Martin J. Bligh wrote:
> >> How many *processors*? Real ones.
> > 
> > Quad P4 Xeon. Dell 6650
> 
> I'd say you definitely want O(1) sched then (or just run -aa or something).
> But why don't you just try it and see?
> 
> M.


Heh..Well, I am currently using 2.4.19rc5aa1. We're having some major
stack problems, so I first when through trying to update the XFS
codebase in 2.4.19rc5aa1. That didn't prove very fruitful. I couldn't
even fully reverse the patch for some reason.

So I decided to try 2.4.20aa1 instead, reversing the xfs patches, and
then updating with a newer code base, worse problems reversing those xfs
patches. 

SO I decided to just roll my own with the known features we use in
production.

2.4.20 + xfs + lvm106 + rmap or aavm + O(1) sched + pte-highmem. 

well, I easily can get rmap+pte-highmem+xfs. Adding O(1) has proven to
be a pain, at least where P4's are concerned. I actually succesfully
merged 2.4.18-o1-p4 optimizations patch, only to have the vmlinux link
fail at the end of the kernel build.

I chased down the problem to an undefined reference to
arch_load_balance, but I can't find anywhere it's actually undefined in
my source.Come to find out, that smp_balance.h is only used for P4's
anyway, or so it said, and that's just my target platform.

I'm really close to nailing it, but I don't know where to go from here.

My build errors are here:
http://digitalroadkill.net/public/kernel/

any of the 2.4.20-rmap* error files. The error3 file has the ld error.
And as for building 2.4.20 with the updated patch, I can't even tell if
it's merged right cause there's not menu entry for the prio. 

--
GrandMasterLee

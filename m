Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317935AbSGPTCM>; Tue, 16 Jul 2002 15:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317939AbSGPTCL>; Tue, 16 Jul 2002 15:02:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2693 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317935AbSGPTCL>;
	Tue, 16 Jul 2002 15:02:11 -0400
Date: Tue, 16 Jul 2002 12:03:52 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch[ Simple Topology API
Message-ID: <1394120000.1026846232@flay>
In-Reply-To: <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The whole "node" concept sounds broken. There is no such thing as a node,
> since even within nodes latencies will easily differ for different CPU's
> if you have local memories for CPU's within a node (which is clearly the
> only sane thing to do).

Define a node as a group of CPUs with the same set of latencies to memory.
Then you get something that makes sense for everyone, and reduces the 
storage of duplicated data. If your latencies for each CPU are different, 
define a 1-1 mapping between nodes and CPUs. If you really want to store
everthing for each CPU, that's fine.

> If you want to model memory behaviour, you should have memory descriptors
> (in linux parlance, "zone_t") have an array of latencies to each CPU. That
> latency is _not_ a "is this memory local to this CPU" kind of number, that
> simply doesn't make any sense. The fact is, what matters is the number of
> hops. Maybe you want to allow one hop, but not five.

I can't help thinking that we'd be better off making the mechanism as generic
as possible, and not trying to predict all the wierd and wonderful things people
might want to do (eg striping), then implement what you describe as a policy 
decision.

M.


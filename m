Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSFXVfg>; Mon, 24 Jun 2002 17:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSFXVff>; Mon, 24 Jun 2002 17:35:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8586 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315287AbSFXVfe>;
	Mon, 24 Jun 2002 17:35:34 -0400
Date: Mon, 24 Jun 2002 14:34:31 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Craig Kulesa <ckulesa@as.arizona.edu>
cc: Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
       Dave Jones <davej@suse.de>, Daniel Phillips <phillips@bonn-fries.net>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rwhron@earthlink.net
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <6660000.1024954471@flay>
In-Reply-To: <Pine.LNX.4.33.0206191322480.2638-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0206191322480.2638-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll try a more varied set of tests tonight, with cpu usage tabulated.
> 
> Please do a few non-swap tests too. 
> 
> Swapping is the thing that rmap is supposed to _help_, so improvements in
> that area are good (and had better happen!), but if you're only looking at
> the swap performance, you're ignoring the known problems with rmap, ie the
> cases where non-rmap kernels do really well.
> 
> Comparing one but not the other doesn't give a very balanced picture..

It would also be interesting to see memory consumption figures for a benchmark 
with many large processes. With this type of load, memory consumption 
through PTEs is already a problem - as far as I can see, rmap triples the 
memory requirement of PTEs through the PTE chain's doubly linked list 
(an additional 8 bytes per entry) ... perhaps my calculations are wrong?  
This is particular problem for databases that tend to have thousands of
processes attatched to a large shared memory area.

A quick rough calculation indicates that the Oracle test I was helping out 
with was consuming almost 10Gb of PTEs without rmap - 30Gb for overhead 
doesn't sound like fun to me ;-(

M.



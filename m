Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbUDGWiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUDGWiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:38:17 -0400
Received: from ns.suse.de ([195.135.220.2]:52198 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264200AbUDGWiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:38:16 -0400
Date: Thu, 8 Apr 2004 00:38:09 +0200
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@osdl.org, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-Id: <20040408003809.01fc979e.ak@suse.de>
In-Reply-To: <5840000.1081377504@flay>
References: <1081373058.9061.16.camel@arrakis>
	<20040407145130.4b1bdf3e.akpm@osdl.org>
	<5840000.1081377504@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2004 15:38:24 -0700
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> I think there are some design issues that still aren't resolved - we've
> been over this a bit before, but I still don't think they're fixed.
> It seems you're still making a copy of the binding structure for every
> VMA, which seems ... extravagent. Can we share them? IIRC, the only 

Sharing is only an optimization that adds more code and potential 
for more bugs (hash tables, locking etc.). 

We can discuss changes when someone shows numbers that additional 
optimizations are needed. I haven't seen such numbers and I'm not convinced
sharing is even a good idea from a design standpoint.  For the first version 
I just aimed to get something working with straight forward code.

To put it all in perspective: a policy is 12 bytes on a 32bit machine
(assuming MAX_NUMNODES <= 32) and 16 bytes on a 64bit machine
(with MAX_NUMNODES <= 64)

-Andi

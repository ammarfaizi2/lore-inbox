Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTLWAmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTLWAmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:42:06 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:1411 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264884AbTLWAmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:42:01 -0500
Message-ID: <3FE78F53.9090302@cyberone.com.au>
Date: Tue, 23 Dec 2003 11:41:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       Andrew Morton <akpm@osdl.org>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: Re: [TRIVIAL PATCH] Use valid node number when unmapping CPUs
References: <3FE74801.2010401@us.ibm.com>
In-Reply-To: <3FE74801.2010401@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Dobson wrote:

> The cpu_2_node array for i386 is initialized to 0 for each CPU, 
> effectively mapping all CPUs to node 0 unless changed.  When we unmap 
> CPUs, however, we stick a -1 in the array, mapping the CPU to an 
> invalid node.  This really isn't helpful.  We should map the CPU to 
> node 0, to make sure that callers of cpu_to_node() and friends aren't 
> returned a bogus node number.  This trivial patch changes the 
> unmapping code to place a 0 in the node mapping for removed CPUs.
>
> Cheers!


I'd prefer it got initialised to -1 for each cpu, and either set to -1
or not touched during unmap.

0 is more bogus than the alternatives, isn't it? At least for the subset
of CPUs not on node 0. Callers should be fixed.



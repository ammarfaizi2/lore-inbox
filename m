Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWCAS64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWCAS64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWCAS64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:58:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41946 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750897AbWCAS6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:58:55 -0500
Date: Wed, 1 Mar 2006 10:58:44 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060301105844.d5b243f2.pj@sgi.com>
In-Reply-To: <200603011934.34136.ak@suse.de>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<200602281813.47234.ak@suse.de>
	<20060301102757.f2eec70e.pj@sgi.com>
	<200603011934.34136.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> The main reason i'm reluctant to use this is that the cpuset fast path
> overhead (e.g. in memory allocators etc.) is quite large

I disagree.

I spent much time minimizing that overhead over the last few months, as
a direct result of your recommendation to do so.

Especially in the case that all tasks are in the root cpuset (as in the
scenario I just suggested for setting this memory spreading policy for
all tasks), the overhead is practically zero.  The key hook is an
inline test done (usually) once per page allocation on an essentially
read only global 'number_of_cpusets' that determines it is <= 1.

I disagree with your "quite large" characterization.

Please explain further.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWDHUeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWDHUeV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 16:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWDHUeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 16:34:21 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:36058 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751408AbWDHUeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 16:34:20 -0400
Date: Sat, 8 Apr 2006 15:28:40 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
Message-ID: <20060408202840.GB26403@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.C8A8F19B8FD@sergelap.hallyn.com> <p73hd549o5u.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73hd549o5u.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andi Kleen (ak@suse.de):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > This patch defines the uts namespace and some manipulators.
> > Adds the uts namespace to task_struct, and initializes a
> > system-wide init namespace which will continue to be used when
> > it makes sense.
> 
> So to get this straight - you want to add a new pointer to 
> task_struct for each possible virtualized entity? 
> 
> After you're doing by how many bytes will task_struct be bloated? 
> I don't think that's a very good approach because you'll crank
> up the per thread memory overhead which is already far too big
> in Linux. Also it adds cache foot print and generally makes
> things slower.
> 
> If anything I would request using a proxy data structure
> that contains all the virtualized namespaces for a set
> of processes. And give each task only has a single pointer
> to one of these.

This is something we've been discussing - whether to use a single
"container" structure pointing to all the namespaces, or put everything
into the task_struct.  Using container structs means more cache misses
and refcounting issues, but keeps task_struct smaller as you point out.

The consensus so far has been to start putting things into task_struct
and move if needed.  At least the performance numbers show that so far
there is no impact.

iirc container patches have been sent before.  Should those be resent,
then, and perhaps this patchset rebased on those?

thanks,
-serge

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRDRBZF>; Tue, 17 Apr 2001 21:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRDRBY4>; Tue, 17 Apr 2001 21:24:56 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:58383 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132959AbRDRBYr>;
	Tue, 17 Apr 2001 21:24:47 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104180124.f3I1OOs155491@saturn.cs.uml.edu>
Subject: Re: [PATCH] Process pinning
To: npollitt@engr.sgi.com
Date: Tue, 17 Apr 2001 21:24:24 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <20010409170823.C2316@engr.sgi.com> from "Nick Pollitt" at Apr 09, 2001 05:08:23 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Pollitt writes:

> Changes to array.c expose cpus_allowed in proc/pid/stat.  
...
> -%lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
> +%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu\n",
...
> -		task->processor);
> +		task->processor,
> +		task->cpus_allowed);

This isn't good. While it might be reasonable to have
an 8*sizeof(long) processor limit in the kernel, it is
not OK to expose this in the API. The API's limit should
be insanely high, like 256 or more.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbTLOV5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTLOV5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:57:54 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:11996 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264106AbTLOV5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:57:50 -0500
Date: Mon, 15 Dec 2003 13:57:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: edjard@ufam.edu.br
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: More questions about 2.6 /proc/meminfo was: (Mem: and Swap: lines in /proc/meminfo)
Message-ID: <20031215215717.GD1769@matchmail.com>
Mail-Followup-To: edjard@ufam.edu.br, Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031214014429.GB1769@matchmail.com> <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com> <20031215185701.GC1769@matchmail.com> <33772.200.212.156.130.1071517210.squirrel@webmail.ufam.edu.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33772.200.212.156.130.1071517210.squirrel@webmail.ufam.edu.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 05:40:10PM -0200, edjard@ufam.edu.br wrote:
> Some days ago we sent this patch for 2.6.0-test11, which gives some useful
> information regarding these data you are requesting.
> 
> We are now changing this patch to provide the data you require. No body
> answered so far if this is ok to be done by the kernel. We did not to
> try to implement it as a module yet.
> 

OK, interesting.  I have some questions below.

>  	buffer += sprintf(buffer,
>  		"VmSize:\t%8lu kB\n"
>  		"VmLck:\t%8lu kB\n"
>  		"VmRSS:\t%8lu kB\n"
>  		"VmData:\t%8lu kB\n"
> +		"RssData:\t%8lu kB\n"
>  		"VmStk:\t%8lu kB\n"
> +		"RssStk:\t%8lu kB\n"
>  		"VmExe:\t%8lu kB\n"
> -		"VmLib:\t%8lu kB\n",
> +		"RssExe:\t%8lu kB\n"
> +		"VmLib:\t%8lu kB\n"
> +		"RssLib:\t%8lu kB\n"
> +		"VmHeap:\t%8lu KB\n"
> +		"RssHeap:\t%8lu KB\n",
>  		mm->total_vm << (PAGE_SHIFT-10),
>  		mm->locked_vm << (PAGE_SHIFT-10),
>  		mm->rss << (PAGE_SHIFT-10),
> -		data - stack, stack,
> -		exec - lib, lib);
> +		data - stack, (phys_data - phys_stack) >> 10,
> +		stack, phys_stack >> 10,
> +		exec - lib, (phys_exec - phys_lib) >> 10,
> +		lib,  phys_lib >> 10,
> +		(mm->brk - mm->start_brk) >> 10, phys_brk >> 10);
>  	up_read(&mm->mmap_sem);
>  	return buffer;
>  }

Kernels without this patch, I'd have to take VmRSS and calculate that
against VmLib, and then have to think about shared memory between threads
and I'm not sure what else.

If I want to get the memory used by all apps from /proc/$pid/status, how am
I going to calculate it with this patch, and how will it be more accurate
from what I'd have to deal with from 2.[246] as they currently are without
the patch?

Thanks,

Mike

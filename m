Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWBFJSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWBFJSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWBFJSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:18:24 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:2792 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750827AbWBFJSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:18:23 -0500
Date: Mon, 6 Feb 2006 10:18:02 +0100 (CET)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0602060959270.11563@openx3.frec.bull.fr>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 06/02/2006 10:19:02,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 06/02/2006 10:19:06,
	Serialize complete at 06/02/2006 10:19:06
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Paul Jackson wrote:

> This policy can provide substantial improvements for jobs that
> need to place thread local data on the corresponding node, but
> that need to access large file system data sets that need to
> be spread across the several nodes in the jobs cpuset in order
> to fit.  Without this patch, especially for jobs that might
> have one thread reading in the data set, the memory allocation
> across the nodes in the jobs cpuset can become very uneven.
> 

Oh, that's good news for me.
I was receiving more and more complains about this kind of issues.
I feel this is really a good answer to the typical "page cache ate all my 
node memory" case, which is *really* a pain for many HPC apps that access 
large files.

Thanks Paul.

AKPM wrote:

> IOW: this patch seems to be a highly specific bandaid which is repairing 
> an ill-advised problem of our own making, does it not?

I'm not sure about the 'ill-advised' part. All our efforts to let the 
kernel do the Right Thing by himself on all situations should not prevent 
us from remembering that Linux is not a time machine, and that sometimes, 
it is just a lot easier and probably better to give the kernel a few hints 
about what it should do.

And even if this can seem 'specific', this kind of workload is NOT rare, 
at least in HPC.

	Simon.

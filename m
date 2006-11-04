Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753561AbWKDBmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbWKDBmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 20:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbWKDBmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 20:42:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753561AbWKDBmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 20:42:10 -0500
Date: Fri, 3 Nov 2006 17:42:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061103174206.53f2c49e.akpm@osdl.org>
In-Reply-To: <20061103172605.e646352a.pj@sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<20061103172605.e646352a.pj@sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 17:26:05 -0800
Paul Jackson <pj@sgi.com> wrote:

> Andrew wrote:
> > But in this application which you are proposing, any correlation with
> > elapsed walltime is very slight.  It's just the wrong baseline to use. 
> > What is the *sense* in it?
> 
> Ah - but time is cheap as dirt, and scales like the common cold virus.
> That makes it sinfully attractive for secondary affect placement cache
> hints like this.
> 
> What else would you suggest?
> 
> Same question applies, I suppose, to my zonelist caching patch that is
> sitting in your *-mm patch stack, where you also had doubts about using
> wall clock time to decay the fullnode hints.

Depends what it's doing.  "number of pages allocated" would be a good
"clock" to use in the VM.  Or pages scanned.  Or per-cpu-pages reloads. 
Something which adjusts to what's going on.

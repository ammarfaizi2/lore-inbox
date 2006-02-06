Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWBFHJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWBFHJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWBFHJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:09:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750786AbWBFHJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:09:18 -0500
Date: Sun, 5 Feb 2006 23:08:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060205230816.4ae6b6e2.akpm@osdl.org>
In-Reply-To: <20060205225629.5d887661.pj@sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060205203711.2c855971.akpm@osdl.org>
	<20060205225629.5d887661.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > IOW: this patch seems to be a highly specific bandaid which is repairing an
> > ill-advised problem of our own making, does it not?
> 
> 
> I am mystified.  I am unable to imagine how you see this memory
> spreading patchset as a response to some damage caused by previous
> work.

Node-local allocation.

> 
> So, the user must tell the kernel it needs this.
>

Well I agree.  And I think that the only way we'll get peak performance for
an acceptaly broad range of applications is to provide many fine-grained
controls and the appropriate documentation and instrumentation to help
developers and administrators use those controls.

We're all on the same page here.  I'm questioning whether slab and
pagecache should be inextricably lumped together though.

Is it possible to integrate the slab and pagecache allocation policies more
cleanly into a process's mempolicy?  Right now, MPOL_* are disjoint.

(Why is the spreading policy part of cpusets at all?  Shouldn't it be part
of the mempolicy layer?)

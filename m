Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTKNT26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbTKNT26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:28:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3596
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264582AbTKNT25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:28:57 -0500
Date: Fri, 14 Nov 2003 11:28:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anton Blanchard <anton@samba.org>
Cc: Jack Steiner <steiner@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031114192858.GL2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Jack Steiner <steiner@sgi.com>, Andrew Morton <akpm@osdl.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20031110215844.GC21632@sgi.com> <20031111082915.GC1130@llm08.in.ibm.com> <20031111115804.4aaafd28.akpm@osdl.org> <20031114174535.GA30388@sgi.com> <20031114191045.GN26020@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114191045.GN26020@krispykreme>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 06:10:46AM +1100, Anton Blanchard wrote:
> 
> > Probably too late for 2.6.0, but here is a patch that disables noirqdebug:
> 
> Why dont you just disable it during boot somewhere in sgi ia64 specific
> code? It doesnt seem right to disable this after all the driver effort
> it took to make it work.
> 
> And yes Im a paid up member of the "we build stupidly big machines"
> club. I'll disable where applicable in ppc64 specific code.

Since the problem only starts when the cache line bounces between the CPUs,
then it might be better to just disable if more than 150 processors are
detected?

If it's a layering voilation to disable this during SMP init, then maybe
there can be a smp-quirks.c file where exceptions can be put.

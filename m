Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVBPGQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVBPGQc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 01:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVBPGQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 01:16:32 -0500
Received: from fsmlabs.com ([168.103.115.128]:7601 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261342AbVBPGQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 01:16:30 -0500
Date: Tue, 15 Feb 2005 23:17:20 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu,
       nathanl@austin.ibm.com
Subject: Re: [PATCH] Run softirqs on proper processor on offline
In-Reply-To: <20050215215146.4c063baf.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0502152308380.26742@montezuma.fsmlabs.com>
References: <20050211232821.GA14499@otto> <Pine.LNX.4.61.0502121019080.26742@montezuma.fsmlabs.com>
 <20050214215948.GA22304@otto> <20050215070217.GB13568@elte.hu>
 <20050216020628.GA25596@otto> <Pine.LNX.4.61.0502152227090.26742@montezuma.fsmlabs.com>
 <20050215215146.4c063baf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > Ensure that we only offline the processor when it's safe and never run 
> >  softirqs in another processor's ksoftirqd context. This also gets rid of 
> >  the warnings in ksoftirqd on cpu offline.
> 
> I don't get it.  ksoftirqd is pinned to its cpu, so why does any of this
> matter?

We take down ksoftirqds at CPU_DEAD time, so there is a brief period 
whereupon there is a ksoftirqd thread for an offline processor, it is at 
this point that ->cpus_allowed won't have it pinned anymore. An online 
processor would then take down that ksoftirqd and exit it.

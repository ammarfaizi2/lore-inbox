Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWIWPek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWIWPek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWIWPej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:34:39 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:50568 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751242AbWIWPei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:34:38 -0400
Date: Sat, 23 Sep 2006 16:34:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Richard J Moore <richardj_moore@uk.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: score-boarding [was Re: [PATCH] Linux Kernel Markers]
In-Reply-To: <OFA620FD83.F72E84C5-ON802571EF.007DCA9D-802571EF.007E6808@uk.ibm.com>
Message-ID: <Pine.LNX.4.64.0609231619220.27459@blonde.wat.veritas.com>
References: <OFA620FD83.F72E84C5-ON802571EF.007DCA9D-802571EF.007E6808@uk.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 15:34:29.0149 (UTC) FILETIME=[C2322CD0:01C6DF25]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Richard J Moore wrote:
> 
> It can for another reason - score-boarding: that's where a byte being
> stored assumes intermediate values due to the bits not being set
> simultaneously. Generally this doesn't cause a problem because data across
> processors is serialised for update by mutexes. However, when applied to
> code all sorts of interesting instructions can execute before the bits
> settle down. I haven't heard of this troubling Intel, but it does occur on
> some current architectures.

I'd not heard of this phenomenon, and it worries me.  There are places
in kernel code where we peek at some volatile variable (perhaps a long)
without locking, and expect to see it in any one of several well-defined
states.  Are you saying that there are architectures supported by Linux,
on which we might see an "impossible" mix of states, due to score-boarding?

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTFLBmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbTFLBmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:42:05 -0400
Received: from miranda.zianet.com ([216.234.192.169]:25106 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264651AbTFLBmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:42:03 -0400
Subject: Re: [patch] as-iosched divide by zero fix
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, bos@serpentine.com,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
In-Reply-To: <1055380257.662.8.camel@localhost>
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>
	 <20030611154122.55570de0.akpm@digeo.com> <1055374476.673.1.camel@localhost>
	 <1055377120.665.6.camel@localhost> <20030611172444.76556d5d.akpm@digeo.com>
	 <1055380257.662.8.camel@localhost>
Content-Type: text/plain
Organization: 
Message-Id: <1055382871.28430.9.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Jun 2003 19:54:31 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 19:10, Robert Love wrote:
> On Wed, 2003-06-11 at 17:24, Andrew Morton wrote:
> 
> > Do you know what the actual oops is?
> 
> I got it all figured out now.
> 
> It is a divide by zero in update_write_batch() called from
> as_completed_request().
> 
> > Odd that starting the X server triggers it.  Be interesting if your patch
> > fixes things for Brian.
> 
> I reproduced it without X.
> 
> The divide by zero is on line 959 with the divide by 'write_time'. It
> can obviously be zero (see line 950). The divide by 'batch' on line 953
> seems safe.
> 
> The correct patch is below.
> 
> Most important question: why are only some of us seeing this?
> 
> 	Robert Love

With regards to the last, here is an anti-AOL! for the oops.  I ran
2.5.70-mm8 for several hours today, doing kernel compiles and running
dbench 64 on ext3, xfs, and jfs.  No oops.  

All while running X (although that now seems moot).  Base distro is RH9
if that could matter.  System is UP (PIII), PREEMPT, IDE, i810 chipset.

Steven


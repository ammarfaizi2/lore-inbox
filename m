Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268515AbUI3C1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268515AbUI3C1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 22:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUI3C1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 22:27:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42638 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268515AbUI3C1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 22:27:00 -0400
Subject: Re: [PATCH/RFC] Simplified Readahead
From: Ram Pai <linuxram@us.ibm.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Steven Pratt <slpratt@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040929231327.GM2061@schnapps.adilger.int>
References: <Pine.LNX.4.44.0409291113580.4449-600000@localhost.localdomain>
	 <415B3845.3010005@austin.ibm.com>
	 <20040929231327.GM2061@schnapps.adilger.int>
Content-Type: text/plain
Organization: 
Message-Id: <1096511206.5481.58.camel@dyn319181.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Sep 2004 19:26:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 16:13, Andreas Dilger wrote:
> On a readahead-related note, I'm wondering how hard it would be to have
> some tunables and/or hooks from the readahead state manchine made
> available to the filesystem?  With the 2.4 readahead code it was basically
> impossible for the filesystem to disable the readahead, I haven't looked
> at the 2.6 readahead enough to determine whether we need that or not.
> 
The best way currently to shutoff readahead is to poke into the file
descriptors' readahead structure and set ra_pages to 0.


> The real issue (reason for turning off RA in 2.4) is that within Lustre
> there can be many DLM extent locks for a single file, so client A can
> be writing to one part of the file, and client B can be reading from
> another part of the same file.  With the stock readahead it wouldn't
> stay within the lock extent boundaries, and we couldn't turn it off
> easily.  Having some sort of FS method that says "don't do RA beyond
> this offset" would be useful here.
> 
> The other problem that Lustre had was that the stock readahead would
> send out page reads in small chunks as the window grew instead of
> sending out large requests that could be turned into large, efficient
> network RPCs.  So the desire would be to have some sort of tunable in
> the readahead state (per fs or per file) that says "don't submit
> another readahead until the window is growing by X pages".
> 
> As it is we've basically had to implement our own readahead code within
> the filesystem in order to get correct behaviour and good performance.
> This is of course not optimal from a code duplication point of view and
> also we don't get any benefits from the algorithm improvements being
> done here.
> 
> 
> The other question is whether the new readahead code takes the latency
> of completing read requests into account when determining the size of
> the readahead window? 

No. it does not currently. But taking that into consideration will be 
tricky.  If Luster does that it would be nice to know how does it.

RP


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVLALji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVLALji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVLALji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:39:38 -0500
Received: from smtp.nedstat.nl ([194.109.98.184]:44006 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S932168AbVLALjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:39:36 -0500
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
X-Greylist: Passed host: 194.109.98.185 whitelisted
Subject: Re: [PATCH 06/12] mm: balance active/inactive list scan rates
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Rik van Riel <riel@redhat.com>, Nick Piggin <npiggin@suse.de>,
       Andrea Arcangeli <andrea@suse.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Magnus Damm <magnus.damm@gmail.com>
In-Reply-To: <20051201102035.606043000@localhost.localdomain>
References: <20051201101810.837245000@localhost.localdomain>
	 <20051201102035.606043000@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 12:39:28 +0100
Message-Id: <1133437168.25941.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 18:18 +0800, Wu Fengguang wrote:
> plain text document attachment
> (mm-balance-active-inactive-list-aging.patch)
> shrink_zone() has two major design goals:
> 1) let active/inactive lists have equal scan rates
> 2) do the scans in small chunks
> 

> The new design:
> 1) keep perfect balance
>    let active_list follow inactive_list in scan rate
> 
> 2) always scan in SWAP_CLUSTER_MAX sized chunks
>    simple and efficient
> 
> 3) will scan at least one chunk
>    the expected behavior from the callers
> 
> The perfect balance may or may not yield better performance, though it
> a) is a more understandable and dependable behavior
> b) together with inter-zone balancing, makes the zoned memories consistent

Nice, this patch effectively separates zone balancing from
active/inactive balancing. I was thinking about doing this this morning
in order to nicely abstract out all the page-replacement code.

Thanks!





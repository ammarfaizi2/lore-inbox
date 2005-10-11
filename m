Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVJKDOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVJKDOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVJKDOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:14:03 -0400
Received: from [218.22.21.1] ([218.22.21.1]:48514 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751366AbVJKDOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:14:01 -0400
Date: Tue, 11 Oct 2005 11:14:20 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] use radix_tree for non-resident page tracking
Message-ID: <20051011031420.GA5328@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
References: <20051010130705.GA5026@mail.ustc.edu.cn> <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com> <20051010161704.GA7679@mail.ustc.edu.cn> <Pine.LNX.4.63.0510101237270.20944@cuia.boston.redhat.com> <20051010171414.GA8194@mail.ustc.edu.cn> <Pine.LNX.4.63.0510101311280.20944@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510101311280.20944@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 01:19:34PM -0400, Rik van Riel wrote:
> On Tue, 11 Oct 2005, WU Fengguang wrote:
> 
> > I now realized that counters in struct zone should be better candidates.
> 
> Probably not, since a logical page could be swapped out from one
> memory zone and paged back in to another.
I managed to keep the page aging of each zone balanced in the patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112856866504476&w=2
Zones in nearby nodes are also made balanced somewhat.

The ages are currently measured by accumulated number of pages pushed into lru.
I wonder that has the side effect of making other activities of each zone
roughly balanced, too. It needs some testing. If so, we can just sum up counters
of each zone in the current node.

-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui

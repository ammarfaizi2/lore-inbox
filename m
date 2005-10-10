Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVJJRNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVJJRNr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVJJRLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:11:09 -0400
Received: from [218.22.21.1] ([218.22.21.1]:9647 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750999AbVJJRKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:10:35 -0400
Date: Tue, 11 Oct 2005 01:14:14 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] use radix_tree for non-resident page tracking
Message-ID: <20051010171414.GA8194@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
References: <20051010130705.GA5026@mail.ustc.edu.cn> <Pine.LNX.4.63.0510100959290.20944@cuia.boston.redhat.com> <20051010161704.GA7679@mail.ustc.edu.cn> <Pine.LNX.4.63.0510101237270.20944@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510101237270.20944@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 12:37:48PM -0400, Rik van Riel wrote:
> > > How are you going to get the inter-reference distance
> > > this way?
> >
> > How about taking down the current sum of `pgfree' in the slot?
> 
> Sounds like a good idea to me.  Definately worth a try!
Thanks.
I now realized that counters in struct zone should be better candidates.

And the slots may be used to calculate the real inter-reference distances
for dropped pages. For the present pages, we can either add entries to each
page, or to radix_tree_node. I suspect the latter is enough because it should
work well with sequential reads and sequential reads are the majority of page
activities and the main source of flushing.

-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui

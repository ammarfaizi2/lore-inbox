Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUFXBYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUFXBYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUFXBYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:24:39 -0400
Received: from holomorphy.com ([207.189.100.168]:44422 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263640AbUFXBYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:24:38 -0400
Date: Wed, 23 Jun 2004 18:24:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <20040624012435.GN1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040623151659.70333c6d.akpm@osdl.org> <20040623223146.GG1552@holomorphy.com> <20040623153758.40e3a865.akpm@osdl.org> <20040623230730.GJ1552@holomorphy.com> <20040623163819.013c8585.akpm@osdl.org> <20040624000308.GK1552@holomorphy.com> <20040623171818.39b73d52.akpm@osdl.org> <20040624002651.GL1552@holomorphy.com> <20040624003249.GM1552@holomorphy.com> <20040623180722.69a8ea6f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623180722.69a8ea6f.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Also, as we're fixing this a different way, could you clarify for me
>> which of the pieces of the original fix or related things (e.g. the
>> zone->all_unreclaimable stuff, yanking PG_wired stuff off the LRU,
>> maybe more) you wanted me to rework and send back in later?

On Wed, Jun 23, 2004 at 06:07:22PM -0700, Andrew Morton wrote:
> Well none, really.  This problem is now fixed, is it not?
> It would be nice to fix up the unrelated issue of putting unbacked pages
> onto the LRU.  Could do that by adding backing_dev_info.not_on_lru, check
> that in the various places where we add pages to the LRU.
> Or, conceivably, do it lazily: take these pages off the LRU if we encounter
> them in page reclaim.  This might be a net win - do extra work for the rare
> case, less work for the common case.
> Something like this:

To me, this resembles reworking the LRU removal bits. I'll flesh out
the example you posted in the way you've suggested (via backing_dev_info).

Thanks.


-- wli

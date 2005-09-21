Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVIUTsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVIUTsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVIUTsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:48:10 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:6104 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932138AbVIUTsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:48:09 -0400
Date: Wed, 21 Sep 2005 12:48:05 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>, Jay Lan <jlan@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0509211246490.11619@schroedinger.engr.sgi.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Hugh Dickins wrote:

> 
> But I think you're right that hiwater_vm is best updated where total_vm
> is: I'm not sure if it covers all cases completely (I think there's one
> or two places which don't bother to call __vm_stat_account because they
> believe it won't change anything), but in principle it would make lots of
> sense to do it in the __vm_stat_account which typically follows adjusting
> total_vm, as you did, and if possible nowhere else; rather than adding
> your inline above.
> 
> Would you be satisfied with that, Christoph?

Looks like this is staying off the critical code paths. So ok.

> I'm also rearranging the rss,anon_rss accounting.  Maybe come back
> to the hiwaters later on?

I'd be very interested to see the rearrangement.

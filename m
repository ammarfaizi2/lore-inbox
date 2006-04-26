Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWDZPpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWDZPpy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWDZPpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:45:54 -0400
Received: from gold.veritas.com ([143.127.12.110]:7075 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964831AbWDZPpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:45:53 -0400
X-IronPort-AV: i="4.04,158,1144047600"; 
   d="scan'208"; a="58969643:sNHT33862192"
Date: Wed, 26 Apr 2006 16:45:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
cc: Jan Beulich <jbeulich@novell.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
In-Reply-To: <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0604261636570.11246@blonde.wat.veritas.com>
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com>
 <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Apr 2006 15:45:51.0869 (UTC) FILETIME=[7F2A7AD0:01C66948]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Keir Fraser wrote:
> 
> We cannot use pte_clear() unless we redefine it for PAE. Currently it reduces
> to set_pte() which explicitly uses the wrong ordering (sets high *then* low,
> because it's normally used to introduce a mapping).

I overlooked that reversal completely.  What a very good point.
I think that actually pte_clear() _does_ need to be redefined for PAE,
to reverse that ordering as you point out.  Take a look at its use in
mm/highmem.c (where a comment states it's safe against speculative
execution, but a comment can't guarantee that!): what do you think?

Hugh

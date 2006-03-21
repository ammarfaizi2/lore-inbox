Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWCUUsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWCUUsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCUUsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:48:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44762 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932446AbWCUUsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:48:54 -0500
Date: Tue, 21 Mar 2006 14:48:45 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Jack Steiner <steiner@sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] - Move call to calc_load()
Message-ID: <20060321204845.GB26124@sgi.com>
References: <20060321203249.GA16182@sgi.com> <20060321203647.GA26135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321203647.GA26135@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 21, 2006 at 09:36:47PM +0100, Ingo Molnar wrote:
> * Jack Steiner <steiner@sgi.com> wrote:
> 
> > Here is the patch that I am proposing. This patch is incomplete 
> > because it addresses only the IA64 architecture. If this approach is 
> > acceptible, I'll update the patch to cover all architectures.
> > 
> > 	Signed-off-by: Jack Steiner <steiner@sgi.com>
> 
> i agree with your analysis - there is no reason calc_load() should be 
> under xtime_lock. I guess no-one noticed this so far because calc_load() 
> iterating over hundreds of CPUs isnt too common.

I tested this patch and it works well for eliminating latencies due to
contention for the xtime_lock.  Without the patch the latencies are
quite substantial at higher cpu counts.

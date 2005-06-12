Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVFLGY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVFLGY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 02:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVFLGYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 02:24:50 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:58070 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261279AbVFLFUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 01:20:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: 2.6.12-rc6-mm1
Date: Sun, 12 Jun 2005 15:19:44 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <piggin@cyberone.com.au>
References: <20050607170853.3f81007a.akpm@osdl.org> <200506120947.13709.kernel@kolivas.org> <675380000.1118535797@[10.10.2.4]>
In-Reply-To: <675380000.1118535797@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506121519.44808.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005 10:23, Martin J. Bligh wrote:
> --Con Kolivas <kernel@kolivas.org> wrote (on Sunday, June 12, 2005 09:47:08 
+1000):
> > The patches should balance things as fairly as possible according to nice
> > levels across cpus. As you can see this is clearly a bug in behaviour and
> > has been a showstopper for many trying to move from 2.4.
>
> Oh, right. that makes a lot of sense ... maybe just let it have an error
> factor when migrating cross numa nodes (ie not be as strict)? Not sure
> that's really the problem, as I doubt anything in my test is actually
> niced anyway (assuming you're meaning static prio, not dynamic). In that
> case, your changes should have no effect, right (from explanation, not
> looking at the code ;-))

The balancing code is not really aware that the loads being returned are being 
altered and it was not clear whether this would be needed or not as it 
usually bases its decisions on ratios of load rather than absolute amounts. 
The tricky part is idle balancing where we don't want to try and pull from a 
queue that only has one running task and the patch has a "if single task 
running and idle balancing tell it only one task running and don't bias" 
feature. This may cause slight performance effects on numa as I guess the 
other nodes suddenly seem much more loaded and we normally wouldn't try 
balancing between nodes until there was a larger load discrepancy than 
between cpus. I'll think on this and see how much more nice-aware the 
balancing code needs to be for this to not have any effect.

Cheers,
Con

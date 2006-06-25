Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWFYR2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWFYR2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWFYR2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:28:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:13215 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751338AbWFYR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:28:46 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <449EC774.5060908@s5r6.in-berlin.de>
Date: Sun, 25 Jun 2006 19:27:16 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2.6.17-mm1 4/3] ieee1394: convert ieee1394_transactions
 from semaphores to waitqueue
References: <449BEBFB.60302@s5r6.in-berlin.de> <200606230904.k5N94Al3005245@shell0.pdx.osdl.net>  <30866.1151072338@warthog.cambridge.redhat.com> <tkrat.df6845846c72176e@s5r6.in-berlin.de> <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de> <tkrat.e74b06c4105348f6@s5r6.in-berlin.de> <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de> <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>
In-Reply-To: <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.894) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote on 2006-06-24:
> +	return wait_event_interruptible(tlabel_wq,
> +					!hpsb_get_tlabel_atomic(packet));

Hmm. "Linux Device Drivers" says about wait_event_interruptible(wq, 
condition): ''Note that @condition may be evaluated an arbitrary number 
of times, so it should not have any side effects.''

Alas the hpsb_get_tlabel_atomic() _does_ have a side effect, but only 
when !hpsb_get_tlabel_atomic(packet) is true.

The current implementation of wait_event_interruptible() seems to 
evaluate @condition multiple times if it is false but only _once_ while 
it is true. May I rely on this fact or do I have to rewrite the 
condition to be completely free of side effects?

I don't believe there would be ever a sensible implementation of 
wait_event_interruptible() which would evaluate @condition again after 
it became true.

Thanks,
-- 
Stefan Richter
-=====-=-==- -==- ==--=
http://arcgraph.de/sr/

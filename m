Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWJRNvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWJRNvJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 09:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWJRNvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 09:51:09 -0400
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:20616 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030260AbWJRNvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 09:51:08 -0400
Message-ID: <45363149.9050607@grupopie.com>
Date: Wed, 18 Oct 2006 14:51:05 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
References: <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain> <20061018124420.GI24452@kernel.dk> <4536245B.8070906@yahoo.com.au> <20061018130456.GJ24452@kernel.dk>
In-Reply-To: <20061018130456.GJ24452@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>[...]
> Precisely, hence CFQ is now based on the time metric. Given larger
> slices, you can mostly eliminate the impact of other applications in the
> system.

Just one thought: we can't predict reliably how much time a request will
take to be serviced, but we can account the time it _took_ to service a
request.

If we account the time it took to service requests for each process, and
we have several processes with requests pending, we can use the same 
algorithm we would use for a large time slice algorithm to select the 
process to service.

This should make it as fair over time as a large time slice algorithm 
and doesn't need large time slices, so latencies can be kept as low as 
required.

However, having a small time slice will probably help the hardware 
coalesce several request from the same process that are more likely to 
be to nearby sectors, and thus improve performance.

I'm leaving out the details, like we should find a way to make the 
"fairness" work over a time window and not over the entire process 
lifespan, maybe by using a sliding window over the last N seconds of 
serviced requests to do the accounting or something.

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."


Return-Path: <linux-kernel-owner+w=401wt.eu-S932907AbWLSTJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbWLSTJz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbWLSTJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:09:55 -0500
Received: from doppler.zen.co.uk ([212.23.3.27]:39757 "EHLO doppler.zen.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901AbWLSTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:09:53 -0500
X-Greylist: delayed 2073 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 14:09:53 EST
X-DSPAM-Result: Innocent
X-DSPAM-Processed: Tue Dec 19 18:34:28 2006
X-DSPAM-Confidence: 0.9997
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 458830b4153491540471188
X-DSPAM-Factors: 27,
X-Spam-Score: -3.968
Message-ID: <458830B9.90107@dresco.co.uk>
Date: Tue, 19 Dec 2006 18:34:33 +0000
From: Jon Escombe <lists@dresco.co.uk>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>, Dan Aloni <da-x@monatomic.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>,
       Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH] scsi_execute_async() should add to the tail of the  queue
References: <20061219083507.GA20847@localdomain> <1166522613.3365.1198.camel@laptopd505.fenrus.org> <20061219112649.GG5010@kernel.dk>
In-Reply-To: <20061219112649.GG5010@kernel.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Heisenberg-IP: [82.68.23.174]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
 > On Tue, Dec 19 2006, Arjan van de Ven wrote:
 >> On Tue, 2006-12-19 at 10:35 +0200, Dan Aloni wrote:
 >>> Hello,
 >>>
 >>> scsi_execute_async() has replaced scsi_do_req() a few versions ago,
 >>> but it also incurred a change of behavior. I noticed that over-queuing
 >>> a SCSI device using that function causes I/Os to be starved from
 >>> low-level queuing for no justified reason.
 >>>
 >>> I think it makes much more sense to perserve the original behaviour
 >>> of scsi_do_req() and add the request to the tail of the queue.
 >> Hi,
 >>
 >> some things should really be added to the head of the queue, like
 >> maintenance requests and error handling requests. Are you sure this is
 >> the right change? At least I'd expect 2 apis, one for a head and one for
 >> a "normal" queueing...
 >
 > It does sounds broken - head insertion should only be used for careful
 > internal commands, not be the default way user issued commands. Looking
 > at the current users, the patch makes sense to me.
 >

It's worth noting that the hdaps disk protection patches rely on the 
current behaviour to add 'IDLE IMMEDIATE WITH UNLOAD' commands to the 
head of the queue.. Another function, or a new parameter for queue 
position would be needed to retain this functionality - any preference 
for either?

Regards,
Jon.


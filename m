Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965435AbWFYT4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965435AbWFYT4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 15:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965437AbWFYT4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 15:56:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46000 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S965435AbWFYT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 15:56:05 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <449EE9F9.1020703@s5r6.in-berlin.de>
Date: Sun, 25 Jun 2006 21:54:33 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2.6.17-mm1 5/3] ieee1394: raw1394: remove redundant
 counting semaphore
References: <449BEBFB.60302@s5r6.in-berlin.de>  <200606230904.k5N94Al3005245@shell0.pdx.osdl.net>  <30866.1151072338@warthog.cambridge.redhat.com>  <tkrat.df6845846c72176e@s5r6.in-berlin.de>  <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>  <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>  <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de>  <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>  <449D7A53.4080605@s5r6.in-berlin.de> <1151172766.3181.75.camel@laptopd505.fenrus.org> <tkrat.fc5e105c2b4b5ef5@s5r6.in-berlin.de>
In-Reply-To: <tkrat.fc5e105c2b4b5ef5@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.896) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
...
> @@ -2864,25 +2877,23 @@ static int raw1394_release(struct inode 
...
> +		/* Sleep until more requests can be freed.
> +		 * FIXME?  This sleeps uninterruptibly. */
> +		wait_event(fi->wait_complete, (req = next_complete_req(fi)));
> +		free_pending_request(req);

We certainly cannot allow anybody to close the file with pending or 
orphaned complete requests, so maybe I should white-out that FIXME.
-- 
Stefan Richter
-=====-=-==- -==- ==--=
http://arcgraph.de/sr/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTGKQoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTGKQoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:44:12 -0400
Received: from dm1-21.slc.aros.net ([66.219.220.21]:49352 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264246AbTGKQoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:44:11 -0400
Message-ID: <3F0EECCA.6090205@aros.net>
Date: Fri, 11 Jul 2003 10:58:50 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, kernel@steeleye.com
Cc: torvalds@osdl.org
Subject: Re: NBD oops in 2.5-bk.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than pushing the memset zero hack to NBD to work around this 
problem, how about we fix this problem where it should be fixed - from 
within the blk_init_queue() function. I'm sorry I'm not offerring a real 
patch right here myself for this but I'd rather defer that to the blk_* 
API experts. The basics of such a patch though would be to simply add 
memset(&q->kobj, 0, sizeof(struct kobject)) to the top of the 
blk_init_queue() function. Andrew's been super involved and has done 
wonderful things with the block layer so I really want him to think 
about where and how to best to initialize the new kobj field of 
request_queue or to say why he (or someone else as qualified) believes 
it should be the driver's responsibility to init this field (instead of 
the blk_init_queue function init'ing it). Thanks!


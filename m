Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUDPNSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263163AbUDPNSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:18:13 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:63131 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263161AbUDPNSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:18:12 -0400
Message-ID: <407FDD0A.1050904@nortelnetworks.com>
Date: Fri, 16 Apr 2004 09:18:02 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abhinav singh <abhinav_is_in@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How-to write soft real-time programs Kernel-2.6.x
References: <20040416082057.93380.qmail@web40304.mail.yahoo.com>
In-Reply-To: <20040416082057.93380.qmail@web40304.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

abhinav singh wrote:

> So how-to write a simple program(may be a Hello world
> program) which has real-time capabilities.


Something like the following will put you into one of the "realtime" 
scheduling classes, and you will take priority over the normally 
scheduled tasks.


struct sched_param p;
p.sched_priority=50;
if (sched_setscheduler(getpid(), SCHED_RR, &p) < 0) {
	perror("error while setting scheduler class");
	printf("continuing anyways, but results may not be as good\n");
}


The whole issue of soft-realtime is a complicated one, and there are 
many other things that should be done to maximise predictability.


Chris

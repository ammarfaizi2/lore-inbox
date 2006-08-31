Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWHaQCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWHaQCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWHaQCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:02:09 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:36582 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP id S932172AbWHaQCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:02:06 -0400
Message-ID: <44F707F5.4090008@nortel.com>
Date: Thu, 31 Aug 2006 10:01:57 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Ohlin <martin.ohlin@control.lth.se>
CC: Mike Galbraith <efault@gmx.de>, Peter Williams <pwil3058@bigpond.net.au>,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com> <44F6365A.8010201@bigpond.net.au> <1157007190.6035.14.camel@Homer.simpson.net> <1157010140.18561.23.camel@Homer.simpson.net> <44F6BB8A.7090001@control.lth.se>
In-Reply-To: <44F6BB8A.7090001@control.lth.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2006 16:02:01.0354 (UTC) FILETIME=[CB7C66A0:01C6CD16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Ohlin wrote:

> Maybe I am wrong, but as I see it, if one wants to control on a group 
> level, then the individual shares within the group are not that 
> important. If the individual share is important, then it should be 
> controlled on a per-task level. Please tell me if I am wrong.

The individual share within the group may not be important, but the 
relative priority might be.


We have instances were we would like to express something like:

--these tasks are all grouped together as "maintenance" tasks, and 
should be guaranteed 3% of the system together
	--within the maintenance tasks, my network heartbeat application is the 
most latency sensitive, so I want it to be higher-priority than the 
other maintenance tasks


 From my point of view, task group cpu allocation and relative task 
priority should be orthogonal.

First you pick a task group (based on cpu share, priority, etc.) then 
within the group you pick the task with highest priority.

This was something that CKRM did right (IMHO).

Chris

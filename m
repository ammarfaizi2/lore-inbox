Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWFSU2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWFSU2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWFSU2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:28:53 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:24791 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP
	id S1750958AbWFSU2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:28:52 -0400
Message-ID: <449708F3.4080706@nortel.com>
Date: Mon, 19 Jun 2006 14:28:35 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sekharan@us.ibm.com
CC: Nick Piggin <nickpiggin@yahoo.com.au>, vatsa@in.ibm.com,
       Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       Balbir Singh <balbir@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au>  <4496E982.3040607@nortel.com> <1150744285.30901.6.camel@linuxchandra>
In-Reply-To: <1150744285.30901.6.camel@linuxchandra>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2006 20:28:40.0181 (UTC) FILETIME=[F35FEA50:01C693DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:

> Resource Groups(CKRM) does allow threads to be in different Resource
> Groups ( and since Resource Group assignment is dynamic, a thread can
> move to a high priority resource group for a specific operation and get
> back to its original resource group after the operation is complete).
> 
> Just wondering if that is sufficient or you _would_ need support from
> NPTL.

The main issue is that the mapping between pthread_t and and PID is only 
known by NPTL.  A thread can find it's own PID (for purposes of resource 
groups) but it can't find the PID of other threads given their pthread_t.

Essentially I'm looking for cpu-group equivalents to:

pthread_setschedparam()
pthread_getschedparam()
pthread_attr_setschedpolicy()
pthread_attr_getschedpolicy()

It's not absolutely critical, but we did add it to our current NPTL.

Chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161616AbWJaJBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161616AbWJaJBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161619AbWJaJBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:01:35 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32043 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161616AbWJaJBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:01:34 -0500
Message-ID: <45470FEE.6040605@openvz.org>
Date: Tue, 31 Oct 2006 11:57:18 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com,
       linux-mm@kvack.org
Subject: Re: [ckrm-tech] RFC: Memory Controller
References: <20061030103356.GA16833@in.ibm.com> <4545D51A.1060808@in.ibm.com> <4546212B.4010603@openvz.org> <454638D2.7050306@in.ibm.com> <45463F70.1010303@in.ibm.com>
In-Reply-To: <45463F70.1010303@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

>> But in general I agree, these are the three important resources for
>> accounting and control
> 
> I missed out to mention, I hope you were including the page cache in
> your definition of reclaimable memory.

As far as page cache is concerned my opinion is the following.
(If I misunderstood you, please correct me.)

Page cache is designed to keep in memory as much pages as
possible to optimize performance. If we start limiting the page
cache usage we cut the performance. What is to be controlled is
_used_ resources (touched pages, opened file descriptors, mapped
areas, etc), but not the cached ones. I see nothing bad if the
page that belongs to a file, but is not used by ANY task in BC,
stays in memory. I think this is normal. If kernel wants it may
push this page out easily it won't event need to try_to_unmap()
it. So cached pages must not be accounted.


I've also noticed that you've [snip]-ed on one of my questions.

 > How would you allocate memory on NUMA in advance?

Please, clarify this.

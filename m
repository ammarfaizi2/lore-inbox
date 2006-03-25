Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWCYJmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWCYJmK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 04:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWCYJmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 04:42:10 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16826 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751138AbWCYJmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 04:42:09 -0500
Date: Sat, 25 Mar 2006 15:11:26 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: jamal <hadi@cyberus.ca>
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink interface for delay accounting
Message-ID: <20060325094126.GA9376@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1142296834.5858.3.camel@elinux04.optonline.net> <1142297791.5858.31.camel@elinux04.optonline.net> <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2> <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2> <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2> <20060324145459.GA7495@in.ibm.com> <1143249565.5184.6.camel@jzny2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143249565.5184.6.camel@jzny2>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 08:19:25PM -0500, jamal wrote:
> On Fri, 2006-24-03 at 20:24 +0530, Balbir Singh wrote:
> 
> > Hmm... Would it be ok to send one message with the following format
> > 
> > 1. TLV=TASKSTATS_TYPE_PID
> > 2. TLV=TASKSTATS_TYPE_STATS
> > 3. TLV=TASKSTATS_TYPE_TGID
> > 4. TLV=TASKSTATS_TYPE_STATS
> > 
> > It would still be one message, except that 3 and 4 would be optional.
> > What do you think?
> > 
> 
> No, that wont work since #2 and #4 are basically the same TLV. [Recall
> that "T" is used to index an array]. Your other alternative is to have
> #4 perhaps called TASKSTATS_TGID_STATS and #2 TASKSTATS_PID_STATS
> although that would smell a little.
> Dont be afraid to do the nest, it will be a little painful initially but
> i am sure once you figure it out you will appreciate it.
>

Thanks for the advice, I will dive into nesting. I could not find any 
in tree users who use nesting, so I have a few questions

nla_nest_start() accepts two parameters an skb and an attribute type.
Do I have to create a new attribute type like TASKSTATS_TYPE_AGGR to
contain the nested attributes 

TASKSTATS_TYPE_AGGR
   TASKSTATS_TYPE_PID/TGID
   TASKSTATS_TYPE_STATS

but this will lead to


TASKSTATS_TYPE_AGGR
   TASKSTATS_TYPE_PID
   TASKSTATS_TYPE_STATS
TASKSTATS_TYPE_AGGR
   TASKSTATS_TYPE_TGID
   TASKSTATS_TYPE_STATS

being returned from taskstats_exit_pid().

The other option is to nest

TASKSTATS_TYPE_PID/TGID
   TASKSTATS_TYPE_STATS

but the problem with this approach is, nla_len contains the length of
all attributes including the nested attribute. So it is hard to find
the offset of TASKSTATS_TYPE_STATS in the buffer.

Do I understand NLA nesting at all? May be I am missing something obvious.

Thanks,
Balbir

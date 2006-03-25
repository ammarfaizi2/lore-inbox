Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWCYRsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWCYRsf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWCYRsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:48:35 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:23758 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S1751483AbWCYRsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:48:33 -0500
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink
	interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060325153632.GA25431@in.ibm.com>
References: <1142303607.24621.63.camel@stark>
	 <1142304506.5219.34.camel@jzny2> <20060322074922.GA1164@in.ibm.com>
	 <1143122686.5186.27.camel@jzny2> <20060323154106.GA13159@in.ibm.com>
	 <1143209061.5076.14.camel@jzny2> <20060324145459.GA7495@in.ibm.com>
	 <1143249565.5184.6.camel@jzny2> <20060325094126.GA9376@in.ibm.com>
	 <1143291133.5184.32.camel@jzny2>  <20060325153632.GA25431@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Sat, 25 Mar 2006 12:48:21 -0500
Message-Id: <1143308901.5184.48.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-25-03 at 21:06 +0530, Balbir Singh wrote:
> On Sat, Mar 25, 2006 at 07:52:13AM -0500, jamal wrote:


I didnt pay attention to failure paths etc; i suppose your testing
should catch those. Getting there, a couple more comments:


> +enum {
> +	TASKSTATS_CMD_UNSPEC = 0,	/* Reserved */
> +	TASKSTATS_CMD_GET,		/* user->kernel request */
> +	TASKSTATS_CMD_NEW,		/* kernel->user event */

Should the comment read "kernel->user event/get-response"


> +
> +static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
> +{


> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
> +		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
> +		rc = fill_pid((pid_t)pid, NULL, &stats);
> +		if (rc < 0)
> +			goto err;
> +
> +		na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_PID);
> +		NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_PID, pid);
> +	} else if (info->attrs[TASKSTATS_CMD_ATTR_TGID]) {

in regards to the elseif above:
Could you not have both PID and TGID passed? From my earlier
understanding it seemed legit, no? if answer is yes, then you will have
to do your sizes + reply TLVs at the end.

Also in regards to the nesting, isnt there a need for nla_nest_cancel in
case of failures to add TLVs?

cheers,
jamal



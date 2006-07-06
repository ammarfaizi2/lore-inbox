Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWGFWxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWGFWxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWGFWxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:53:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751008AbWGFWxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:53:45 -0400
Date: Thu, 6 Jul 2006 15:56:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: tgraf@suug.ch, jlan@sgi.com, pj@sgi.com, Valdis.Kletnieks@vt.edu,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
 exit data through cpumasks]
Message-Id: <20060706155643.2cd37b80.akpm@osdl.org>
In-Reply-To: <44AD8E65.70006@watson.ibm.com>
References: <44ACD7C3.5040008@watson.ibm.com>
	<20060706025633.cd4b1c1d.akpm@osdl.org>
	<1152185865.5986.15.camel@localhost.localdomain>
	<20060706120835.GY14627@postel.suug.ch>
	<20060706144808.1dd5fadf.akpm@osdl.org>
	<44AD8E65.70006@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> Andrew Morton wrote:
> > Thomas Graf <tgraf@suug.ch> wrote:
> > 
> >>* Shailabh Nagar <nagar@watson.ibm.com> 2006-07-06 07:37
> >>
> >>>@@ -37,9 +45,26 @@ static struct nla_policy taskstats_cmd_g
> >>> __read_mostly = {
> >>> 	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
> >>> 	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
> >>>+	[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK] = { .type = NLA_STRING },
> >>>+	[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK] = { .type = NLA_STRING },};
> >>
> >>>+		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
> >>>+		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> >>>+			return -E2BIG;
> >>>+		rc = cpulist_parse((char *)nla_data(na), mask);
> >>
> >>This isn't safe, the data in the attribute is not guaranteed to be
> >>NUL terminated. Still it's probably me to blame for not making
> >>this more obvious in the API.
> >>
> > 
> > 
> > Thanks, that was an unpleasant bug.
> > 
> > 
> >>I've attached a patch below extending the API to make it easier
> >>for interfaces using NUL termianted strings,
> > 
> > 
> > In the interests of keeping this work decoupled from netlink enhancements
> > I'd propose the below.  
> 
> The patch looks good. I was also thinking of simply modifying the input
> to have the null termination and modify later when netlink provides
> generic support.
> 
> 

Yup.  Thomas, what's the testing status of the netlink patch you sent?  Should I
queue it up and start plagueing people with it?


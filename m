Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161449AbWJaDIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161449AbWJaDIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161520AbWJaDIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:08:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40874 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161449AbWJaDIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:08:40 -0500
Message-ID: <4546BE24.5000504@sgi.com>
Date: Mon, 30 Oct 2006 19:08:20 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: Jay Lan <jlan@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xacct_add_tsk: fix pure theoretical ->mm use-after-free
References: <20061029185826.GA1619@oleg> <454649CE.80804@engr.sgi.com> <20061030204125.GB677@oleg>
In-Reply-To: <20061030204125.GB677@oleg>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 10/30, Jay Lan wrote:
>> Oleg Nesterov wrote:
>>> Paranoid fix. The task can free its ->mm after the 'if (p->mm)' check.
>> Why this change is necessary? This routine is indirectly invoked by
>> taskstats_exit_send() routine called inside do_exit():
> 
> Not only, please note
> 
> 	taskstats_user_cmd(TASKSTATS_CMD_ATTR_PID)->fill_pid()->xacct_add_tsk()
> 
> path. This tsk is not 'current', it was found by find_task_by_pid(), and
> it may exit at any time.

OK. Thanks!

Acked-by: Jay Lan <jlan@sgi.com>

> 
> Oleg.
> 

